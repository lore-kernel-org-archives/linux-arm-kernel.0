From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  9 Jun 2015 18:46:59 +0200
Subject: [PATCH 07/34] pinctrl: mvebu: armada-375: remove incorrect space in
 pin description
In-Reply-To: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1433868446-11028-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was an incorrect space in the definition of the function of one
pin in the Armada 375 pinctrl driver, which this commit fixes.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: <stable@vger.kernel.org> # v3.15+
Fixes: ce3ed59dcddd ("pinctrl: mvebu: add pin-muxing driver for the Marvell Armada 375")
---
 drivers/pinctrl/mvebu/pinctrl-armada-375.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-375.c b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
index e740a42..203291b 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-375.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-375.c
@@ -92,7 +92,7 @@ static struct mvebu_mpp_mode mv88f6720_mpp_modes[] = {
 		 MPP_FUNCTION(0x5, "nand", "io1")),
 	MPP_MODE(8,
 		 MPP_FUNCTION(0x0, "gpio", NULL),
-		 MPP_FUNCTION(0x1, "dev ", "bootcs"),
+		 MPP_FUNCTION(0x1, "dev", "bootcs"),
 		 MPP_FUNCTION(0x2, "spi0", "cs0"),
 		 MPP_FUNCTION(0x3, "spi1", "cs0"),
 		 MPP_FUNCTION(0x5, "nand", "ce")),
-- 
2.1.0
