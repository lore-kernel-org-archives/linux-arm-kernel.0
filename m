From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  3 Mar 2012 23:20:00 +0800
Subject: [PATCH 19/20] ASoC: rename sgtl5000 device tree binding document
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330788001-10158-20-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It moves and renames sgtl5000 device tree binding document to make
it aligned with other codecs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../{soc/codecs/fsl-sgtl5000.txt => sgtl5000.txt}  |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/sound/{soc/codecs/fsl-sgtl5000.txt => sgtl5000.txt} (100%)

diff --git a/Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
similarity index 100%
rename from Documentation/devicetree/bindings/sound/soc/codecs/fsl-sgtl5000.txt
rename to Documentation/devicetree/bindings/sound/sgtl5000.txt
-- 
1.7.5.4
