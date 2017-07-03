From: hugues.fruchet@st.com (Hugues Fruchet)
Date: Mon, 3 Jul 2017 11:16:03 +0200
Subject: [PATCH v2 2/7] [media] ov9650: switch i2c device id to lower case
In-Reply-To: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
References: <1499073368-31905-1-git-send-email-hugues.fruchet@st.com>
Message-ID: <1499073368-31905-3-git-send-email-hugues.fruchet@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch i2c device id to lower case as it is
done for other omnivision cameras.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/i2c/ov9650.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov9650.c b/drivers/media/i2c/ov9650.c
index 2de2fbb..1e4e99e 100644
--- a/drivers/media/i2c/ov9650.c
+++ b/drivers/media/i2c/ov9650.c
@@ -1545,8 +1545,8 @@ static int ov965x_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ov965x_id[] = {
-	{ "OV9650", 0 },
-	{ "OV9652", 0 },
+	{ "ov9650", 0 },
+	{ "ov9652", 0 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, ov965x_id);
-- 
1.9.1
