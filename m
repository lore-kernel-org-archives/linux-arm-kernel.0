From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 15 Jan 2013 06:54:26 -0300
Subject: [PATCH 2/6] arm: mvebu: Enable USB controllers on Armada 370
 evaluation board
In-Reply-To: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1358243670-11935-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Lior Amsalem <alior@marvell.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 8e66a7c..3d93902 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -74,5 +74,13 @@
 			status = "disabled";
 			/* No CD or WP GPIOs */
 		};
+
+		usb at d0050000 {
+			status = "okay";
+		};
+
+		usb at d0051000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.8.6
