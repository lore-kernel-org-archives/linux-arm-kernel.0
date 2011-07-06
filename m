From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:21 -0400
Subject: [PATCH 36/52] ARM: mach-rpc: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-36-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-rpc/riscpc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index fd086ff..3e3d7d7 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -222,7 +222,7 @@ extern struct sys_timer ioc_timer;
 
 MACHINE_START(RISCPC, "Acorn-RiscPC")
 	/* Maintainer: Russell King */
-	.boot_params	= 0x10000100,
+	.atag_offset	= 0x100,
 	.reserve_lp0	= 1,
 	.reserve_lp1	= 1,
 	.map_io		= rpc_map_io,
-- 
1.7.4
