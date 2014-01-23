From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Jan 2014 15:00:39 +0000
Subject: [PATCH 1/1] openfirmware: trivial: Standardise formatting of 'struct
 of_device_id' definition
Message-ID: <1390489239-29001-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's commonly accepted that when defining a struct the '{' is appended
onto the first line. This helps when searching for the definition using
syntax similar to 'struct of_device_id {'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mod_devicetable.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index 45e9214..090e014 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -220,8 +220,7 @@ struct serio_device_id {
 /*
  * Struct used for matching a device
  */
-struct of_device_id
-{
+struct of_device_id {
 	char	name[32];
 	char	type[32];
 	char	compatible[128];
-- 
1.8.3.2
