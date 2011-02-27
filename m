From: linux@prisktech.co.nz (Linux Mailing List Email Account)
Date: Sun, 27 Feb 2011 00:05:03 -0000
Subject: [PATCH 0/3] VIA/Wondermedia clock support
Message-ID: <76F764B079F92A4E843589C893D0A02264D1@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch to provide clk_ support on the VIA VT8500/Wondermedia WM8505 SoC.

Signed-off-by: Tony Prisk (linux at prisktech.co.nz)
--- arch/arm/mach-vt8500/Makefile    2011-02-27 12:50:29.000000000 +1300
+++ arch/arm/mach-vt8500/Makefile    2011-02-27 12:50:04.000000000 +1300
@@ -4,1 +4,1 @@
-+obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o
++obj-$(CONFIG_VTWM_VERSION_WM8505) += devices-wm8505.o clock.o wm8505-clocks.o

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110227/a4efe74f/attachment.html>
