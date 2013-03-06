From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  6 Mar 2013 11:23:36 +0100
Subject: [PATCH 4/4] arm: mach-orion5x: fix typo in compatible string of a
 .dts file
In-Reply-To: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362565416-15718-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362565416-15718-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The orion5x-lacie-ethernet-disk-mini-v2.dts file was using
"marvell-orion5x-88f5182" as a compatible string, while it should have
been "marvell,orion5x-88f5182".

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 5a3a58b..0077fc8 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "LaCie Ethernet Disk mini V2";
-	compatible = "lacie,ethernet-disk-mini-v2", "marvell-orion5x-88f5182", "marvell,orion5x";
+	compatible = "lacie,ethernet-disk-mini-v2", "marvell,orion5x-88f5182", "marvell,orion5x";
 
 	memory {
 		reg = <0x00000000 0x4000000>; /* 64 MB */
-- 
1.7.9.5
