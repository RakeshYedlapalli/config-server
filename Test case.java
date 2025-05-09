import org.apache.avro.io.Encoder;
import org.apache.avro.io.EncoderFactory;
import org.apache.avro.io.DatumWriter;
import org.apache.avro.specific.SpecificDatumWriter;
import org.apache.avro.Schema;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayOutputStream;
import java.util.Arrays;

import static org.junit.jupiter.api.Assertions.assertThrows;

public class AvroDeserializationTest {

    @Test
    void testIOExceptionOnCorruptedAvro() throws Exception {
        // Step 1: Serialize real Avro object
        MyAvroClass original = new MyAvroClass();
        original.setName("Test Name");

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        DatumWriter<MyAvroClass> writer = new SpecificDatumWriter<>(MyAvroClass.class);
        Encoder encoder = EncoderFactory.get().binaryEncoder(out, null);
        writer.write(original, encoder);
        encoder.flush();

        byte[] fullData = out.toByteArray();

        // Step 2: Corrupt the byte array (truncate a few bytes)
        byte[] corruptedData = Arrays.copyOf(fullData, fullData.length - 2);

        // Step 3: Call your unchanged method
        assertThrows(FRFBuilderException.class, () -> {
            new AvroDeserializationTest().deserializeAvro(corruptedData, MyAvroClass.class, MyAvroClass.SCHEMA);
        });
    }

    // Your unchanged method (can be moved to a separate class)
    public <T extends SpecificRecord> T deserializeAvro(byte[] bytes, Class<T> clazz, Schema schema) {
        try {
            Decoder decoder = DecoderFactory.get().binaryDecoder(new ByteArrayInputStream(bytes), null);
            return new SpecificDatumReader<>(clazz).read(null, decoder);
        } catch (IOException e) {
            throw new FRFBuilderException(e);
        }
    }
}
