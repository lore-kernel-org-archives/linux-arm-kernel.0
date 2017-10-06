From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Fri,  6 Oct 2017 12:13:30 +0200
Subject: [PATCH 02/16] pinctrl: dt-bindings: Fix A37xx uart2 group name
In-Reply-To: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
Message-ID: <20171006101344.15590-3-miquel.raynal@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a typo in A37xx pin controllers documentation about uart2 pin group.

Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt       | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
index f64060908d5a..c7c088d2dd50 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
@@ -97,8 +97,8 @@ group spi_quad
  - pins 15-16
  - functions spi, gpio
 
-group uart_2
- - pins 9-10
+group uart2
+ - pins 9-10 and 18-19
  - functions uart, gpio
 
 Available groups and functions for the South bridge:
-- 
2.11.0
