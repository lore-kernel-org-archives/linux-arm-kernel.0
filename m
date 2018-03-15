From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Mar 2018 17:50:41 +0100
Subject: [PATCH 39/60] arm: dts: kirkwood-pogo_e02: use SPDX-License-Identifier
In-Reply-To: <20180315165102.27160-1-gregory.clement@bootlin.com>
References: <20180315165102.27160-1-gregory.clement@bootlin.com>
Message-ID: <20180315165102.27160-40-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the recent trend for the license description

Cc: Christoph Junghans <ottxor@gentoo.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm/boot/dts/kirkwood-pogo_e02.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-pogo_e02.dts b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
index a190080c9c4f..f9e95e55f36d 100644
--- a/arch/arm/boot/dts/kirkwood-pogo_e02.dts
+++ b/arch/arm/boot/dts/kirkwood-pogo_e02.dts
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * kirkwood-pogo_e02.dts - Device tree file for Pogoplug E02
  *
@@ -7,9 +8,6 @@
  *  Arch Linux ARM by Oleg Rakhmanov <moonman.ca@gmail.com>
  *  OpenWrt by Felix Kaechele <heffer@fedoraproject.org>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /dts-v1/;
-- 
2.16.1
