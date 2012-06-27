From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 27 Jun 2012 21:45:23 +0800
Subject: [PATCH v2 4/5] net: fec: phy-reset-gpios is optional
In-Reply-To: <1340804724-29410-1-git-send-email-shawn.guo@linaro.org>
References: <1340804724-29410-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340804724-29410-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phy-reset-gpios is an optional property for fec device tree boot.
Change the binding document to match the driver code.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 Documentation/devicetree/bindings/net/fsl-fec.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
index 7ab9e1a..0428920 100644
--- a/Documentation/devicetree/bindings/net/fsl-fec.txt
+++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
@@ -7,10 +7,10 @@ Required properties:
 - phy-mode : String, operation mode of the PHY interface.
   Supported values are: "mii", "gmii", "sgmii", "tbi", "rmii",
   "rgmii", "rgmii-id", "rgmii-rxid", "rgmii-txid", "rtbi", "smii".
-- phy-reset-gpios : Should specify the gpio for phy reset
 
 Optional properties:
 - local-mac-address : 6 bytes, mac address
+- phy-reset-gpios : Should specify the gpio for phy reset
 
 Example:
 
-- 
1.7.5.4
