From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 22 Sep 2011 22:51:29 -0700
Subject: [PATCH 2/4] ARM: CSR: timer: space required before the open
	parenthesis '('
In-Reply-To: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
References: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1316757091-14916-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
index 225ed3b..26ab6fe 100644
--- a/arch/arm/mach-prima2/timer.c
+++ b/arch/arm/mach-prima2/timer.c
@@ -140,7 +140,7 @@ unsigned long long notrace sched_clock(void)
 	 * if we map timer memory in .init of sys_timer, system
 	 * will panic due to illegal memory access
 	 */
-	if(!is_mapped) {
+	if (!is_mapped) {
 		sirfsoc_of_timer_map();
 		is_mapped = 1;
 	}
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
