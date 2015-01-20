From: romain.perier@gmail.com (Romain Perier)
Date: Tue, 20 Jan 2015 07:09:40 +0000
Subject: [PATCH v2 4/4] dt-bindings: Document phy-supply property in
 rockchip-dwmac
In-Reply-To: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
References: <1421737780-1533-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1421737780-1533-5-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As no property for phy regulator was documented in this dt-binding documentation,
this commit adds an entry for the optional property phy-supply.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
index 2362dcd..21fd199 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.txt
@@ -33,6 +33,7 @@ Required properties:
 Optional properties:
  - tx_delay: Delay value for TXD timing. Range value is 0~0x7F, 0x30 as default.
  - rx_delay: Delay value for RXD timing. Range value is 0~0x7F, 0x10 as default.
+ - phy-supply: phandle to a regulator if the PHY needs one
 
 Example:
 
-- 
1.9.1
