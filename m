From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Mon, 5 Sep 2016 18:01:30 +0800
Subject: [PATCH 2/7] [v2] dt-bindings: i2c: adds two more nxp devices
In-Reply-To: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473069695-33092-3-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

"nxp,pcf2127" and "nxp,pcf2129" are I2c devices, adds them to the list
of trivial i2c devices.

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
changes in V2:
new patch.

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 5c70ce9..677b168 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -129,6 +129,8 @@ nuvoton,npct501		i2c trusted platform module (TPM)
 nuvoton,npct601		i2c trusted platform module (TPM2)
 nxp,pca9556		Octal SMBus and I2C registered interface
 nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
+nxp,pcf2127		Real-time clock
+nxp,pcf2129		Real-time clock
 nxp,pcf8563		Real-time clock/calendar
 nxp,pcf85063		Tiny Real-Time Clock
 oki,ml86v7667		OKI ML86V7667 video decoder
-- 
2.1.0.27.g96db324
