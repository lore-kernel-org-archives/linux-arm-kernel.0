From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 27 Oct 2011 13:33:49 +0200
Subject: [PATCH] clk: add definition of HAVE_CLK_PREPARE in Kconfig
In-Reply-To: <E1R8T0C-0003wI-W2@rmk-PC.arm.linux.org.uk>
References: <E1R8T0C-0003wI-W2@rmk-PC.arm.linux.org.uk>
Message-ID: <20111027113349.GA4090@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Domenico Andreoli <cavokz@gmail.com>

Add definition of HAVE_CLK_PREPARE in Kconfig otherwise it is not
selected when needed.

Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---
 drivers/clk/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

Index: b/drivers/clk/Kconfig
===================================================================
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -5,3 +5,6 @@ config CLKDEV_LOOKUP
 
 config HAVE_MACH_CLKDEV
 	bool
+
+config HAVE_CLK_PREPARE
+	bool
