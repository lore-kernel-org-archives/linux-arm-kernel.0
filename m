From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 May 2010 19:43:18 -0700
Subject: [PATCH 13/13] omap3: Add stalker board to omap3_defconfig
In-Reply-To: <20100518023707.21705.26205.stgit@baageli.muru.com>
References: <20100518023707.21705.26205.stgit@baageli.muru.com>
Message-ID: <20100518024318.21705.51140.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add stalker board to omap3_defconfig

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_defconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 0eb1bc9..94dfcf0 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -303,6 +303,7 @@ CONFIG_MACH_OMAP_ZOOM2=y
 CONFIG_MACH_OMAP_ZOOM3=y
 CONFIG_MACH_CM_T35=y
 CONFIG_MACH_IGEP0020=y
+CONFIG_MACH_SBC3530=y
 CONFIG_MACH_OMAP_3630SDP=y
 CONFIG_MACH_OMAP_4430SDP=y
 # CONFIG_OMAP3_EMU is not set
