From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Oct 2009 15:12:39 -0700
Subject: [PATCH 07/10] omap2: Fix console serial port number for n8x0
In-Reply-To: <20091022221013.27408.443.stgit@localhost>
References: <20091022221013.27408.443.stgit@localhost>
Message-ID: <20091022221239.27408.80500.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the recent changes omap serial ports match the physical
numbering like they should. Fix the kernel CMDLINE accordingly
so console works.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/n8x0_defconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/n8x0_defconfig b/arch/arm/configs/n8x0_defconfig
index 8da75de..264f52b 100644
--- a/arch/arm/configs/n8x0_defconfig
+++ b/arch/arm/configs/n8x0_defconfig
@@ -304,7 +304,7 @@ CONFIG_ALIGNMENT_TRAP=y
 CONFIG_ZBOOT_ROM_TEXT=0x10C08000
 CONFIG_ZBOOT_ROM_BSS=0x10200000
 # CONFIG_ZBOOT_ROM is not set
-CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS0,115200n8"
+CONFIG_CMDLINE="root=1f03 rootfstype=jffs2 console=ttyS2,115200n8"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
