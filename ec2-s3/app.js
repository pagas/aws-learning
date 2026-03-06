const express = require("express");
const { S3Client, GetObjectCommand } = require("@aws-sdk/client-s3");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

const app = express();
const PORT = 3000;

const s3 = new S3Client({
    region: "us-east-1"
});

app.get("/", async (req, res) => {
    try {
        const command = new GetObjectCommand({
            Bucket: "pg-task3-demo-bucket",
            Key: "random.jpg"
        });

        const signedUrl = await getSignedUrl(s3, command, { expiresIn: 3600 });

        res.send(`
      <h1>Your S3 Image (Signed URL)</h1>
      <img src="${signedUrl}" style="max-width:400px;" />
    `);
    } catch (error) {
        res.status(500).send("Error generating image URL: " + error);
    }
});

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));