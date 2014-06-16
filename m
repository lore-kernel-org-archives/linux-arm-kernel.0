From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 16 Jun 2014 12:06:36 +0100
Subject: [PATCH] mmc: core: Fix DT documentation of eMMC high-speed DDR
 1.8/1.2V bindings.
Message-ID: <1402916796-1450-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the documentation doesn't match the code in mmc_of_parse. This
patch rectifies this.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 9dce540..9c96033 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -34,8 +34,8 @@ Optional properties:
 - cap-power-off-card: powering off the card is safe
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
 - full-pwr-cycle: full power cycle of the card is supported
-- mmc-highspeed-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
-- mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
+- mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
+- mmc-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
 - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
 - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
 
-- 
1.9.1
