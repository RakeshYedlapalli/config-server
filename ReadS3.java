import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.GetObjectResponse;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelConfigLoader {

    public static Map<String, String> loadConfig(S3Client s3Client, String bucket, String key, String envColumnName) throws Exception {
        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(bucket)
                .key(key)
                .build();

        try (InputStream inputStream = s3Client.getObject(getObjectRequest);
             Workbook workbook = new XSSFWorkbook(inputStream)) {

            Sheet sheet = workbook.getSheetAt(0); // or use workbook.getSheet("E2E_Config")
            Row headerRow = sheet.getRow(0);
            int keyIndex = 1; // column index of "Key"
            int envIndex = -1;

            // Find column index for the given env (e.g., "DEV", "PROD")
            for (Cell cell : headerRow) {
                if (cell.getStringCellValue().equalsIgnoreCase(envColumnName)) {
                    envIndex = cell.getColumnIndex();
                    break;
                }
            }

            if (envIndex == -1) throw new RuntimeException("Environment column not found: " + envColumnName);

            Map<String, String> configMap = new HashMap<>();

            // Start from row 1 (skip headers)
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                Cell keyCell = row.getCell(keyIndex);
                Cell valueCell = row.getCell(envIndex);

                if (keyCell != null && valueCell != null) {
                    String keyVal = keyCell.getStringCellValue();
                    String val = valueCell.toString().trim(); // handles numbers and strings
                    configMap.put(keyVal, val);
                }
            }

            return configMap;
        }
    }
}
