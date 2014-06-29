From: a.heider@gmail.com (Andre Heider)
Date: Sun, 29 Jun 2014 18:21:47 +0200
Subject: [PATCH 13/13] ARM: dts: am335x-boneblack: enable the PRUSSv2 device
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Message-ID: <1404058907-21112-14-git-send-email-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 305975d..eeb5c2e 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -75,3 +75,7 @@
 		status = "okay";
 	};
 };
+
+&pruss {
+	status = "okay";
+};
-- 
2.0.0
