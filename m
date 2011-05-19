From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 19 May 2011 14:08:29 +0200
Subject: [PATCH 5/6] ARM: tegra: paz00: change the machine name
In-Reply-To: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
References: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
Message-ID: <1305806910-3903-6-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This renames "paz00" in MACHINE_START macro to a neater string.
PAZ00 seems to have been the Compal internal project name, while
PROCYON looks like Toshiba project name.
Anyway, the AC100 support package in Ubuntu needs the new naming to
identify the machine.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 7fdc409..1b076f6 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -169,7 +169,7 @@ static void __init tegra_paz00_init(void)
 	paz00_usb_init();
 }
 
-MACHINE_START(PAZ00, "paz00")
+MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
 	.boot_params	= 0x00000100,
 	.fixup		= tegra_paz00_fixup,
 	.map_io         = tegra_map_common_io,
-- 
1.7.4.2
