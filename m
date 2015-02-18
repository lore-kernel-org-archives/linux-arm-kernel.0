From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 18 Feb 2015 19:25:57 +0100
Subject: [PATCH 4/6] ASoC: samsung: Document binding for max98089 based Snow
 driver
In-Reply-To: <1424283959-16289-1-git-send-email-afaerber@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
Message-ID: <1424283959-16289-5-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/sound/snow.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/snow.txt b/Documentation/devicetree/bindings/sound/snow.txt
index 6df74f15687f..1430a6bdb2ae 100644
--- a/Documentation/devicetree/bindings/sound/snow.txt
+++ b/Documentation/devicetree/bindings/sound/snow.txt
@@ -2,6 +2,7 @@ Audio Binding for Snow boards
 
 Required properties:
 - compatible : Can be one of the following,
+			"google,snow-audio-max98089" or
 			"google,snow-audio-max98090" or
 			"google,snow-audio-max98091" or
 			"google,snow-audio-max98095"
-- 
2.1.4
