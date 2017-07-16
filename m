From: vesa.jaaskelainen@vaisala.com (=?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?=)
Date: Sun, 16 Jul 2017 23:00:55 +0300
Subject: [RFC PATCH 1/2] Documentation: devicetree: root node board-revision
 property documentation
In-Reply-To: <1500235256-48937-1-git-send-email-vesa.jaaskelainen@vaisala.com>
References: <1500235256-48937-1-git-send-email-vesa.jaaskelainen@vaisala.com>
Message-ID: <1500235256-48937-2-git-send-email-vesa.jaaskelainen@vaisala.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board revision is hardware revision for board. Meaning of hardware
revision is defined by device/SoM manufacturer and because of that it is
defined as a string.

Board revision information can be stored in hardware identifier resistors,
eFuses, EEPROM or some other device specific non-volatile storage. It is
expected that bootloader will analyse board revision information and pass
it in device tree to kernel.

Signed-off-by: Vesa J??skel?inen <vesa.jaaskelainen@vaisala.com>
---
 Documentation/devicetree/booting-without-of.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index fb74044..ae8f5ec 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -872,6 +872,7 @@ address which can extend beyond that limit.
   Additional properties for the root node:
 
     - serial-number : a string representing the device's serial number
+    - board-revision : a string representing the board's revision
 
   b) The /cpus node
 
-- 
2.1.4
