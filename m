From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 21:54:25 +0100
Subject: [PATCH v4 5/5] drm/docs: Remove the rcar alpha from the csv file
In-Reply-To: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
References: <cover.b32b447321f6e04da30ed8099fbef2f00fc27fbc.1520974361.git-series.maxime.ripard@bootlin.com>
Message-ID: <be055447ca764ace36b71d2c2520578f89705176.1520974361.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we moved the rcar-du DRM driver has been switched to the generic
alpha property, remove the former property documentation from the
deperecated CSV file.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/gpu/kms-properties.csv | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
index 6b28b014cb7d..07ed22ea3bd6 100644
--- a/Documentation/gpu/kms-properties.csv
+++ b/Documentation/gpu/kms-properties.csv
@@ -98,5 +98,4 @@ radeon,DVI-I,?coherent?,RANGE,"Min=0, Max=1",Connector,TBD
 ,,"""underscan vborder""",RANGE,"Min=0, Max=128",Connector,TBD
 ,Audio,?audio?,ENUM,"{ ""off"", ""on"", ""auto"" }",Connector,TBD
 ,FMT Dithering,?dither?,ENUM,"{ ""off"", ""on"" }",Connector,TBD
-rcar-du,Generic,"""alpha""",RANGE,"Min=0, Max=255",Plane,TBD
 ,,"""colorkey""",RANGE,"Min=0, Max=0x01ffffff",Plane,TBD
-- 
git-series 0.9.1
