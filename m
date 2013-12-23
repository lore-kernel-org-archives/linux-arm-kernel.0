From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:51 +0900
Subject: [PATCH] ARM: shmobile: remove unnecessary platform_device as header
 cleanup
In-Reply-To: <cover.1387762178.git.horms+renesas@verge.net.au>
References: <cover.1387762178.git.horms+renesas@verge.net.au>
Message-ID: <2eb7a8146f5ab5be7cde42438e32461f313d0d0b.1387762178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

8e0e7aaef3c98c52e85f5640b73ffa82058abcfd
(ARM: shmobile: Drop r8a7779_add_device_to_domain())
removed last user of struct platform_device on this header.
It is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 5014145..b40e136 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -11,8 +11,6 @@ enum {
 	HPBDMA_SLAVE_SDHI0_RX,
 };
 
-struct platform_device;
-
 struct r8a7779_pm_ch {
 	unsigned long chan_offs;
 	unsigned int chan_bit;
-- 
1.8.4
