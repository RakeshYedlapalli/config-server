import java.util.HashMap;
import java.util.Map;

public static Map<String, String> getParamsAsMap(String params) {
    Map<String, String> resultMap = new HashMap<>();
    
    if (params == null || params.isEmpty()) {
        return resultMap;
    }

    String[] pairs = params.split(PARAM_SEPARATOR);
    for (String pair : pairs) {
        String[] keyValue = pair.split(PARAM_EQUAL, 2); // Limit to 2 to handle '=' in values
        if (keyValue.length == 2) {
            resultMap.put(keyValue[0], keyValue[1]);
        } else if (keyValue.length == 1) {
            resultMap.put(keyValue[0], ""); // Handle keys without values
        }
    }

    return resultMap;
}
