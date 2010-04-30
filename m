From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 13:33:52 -0700
Subject: [PATCH 03/11] omap3: Fix compile for board-cm-t35
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Message-ID: <20100430203352.25812.64001.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise we can get the following error:

error: variable 'tdo24m_mcspi_config' has initializer but incomplete type
...

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-cm-t35.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 2de4f79..e679a2c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -45,6 +45,7 @@
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/display.h>
+#include <plat/mcspi.h>
 
 #include <mach/hardware.h>
 
