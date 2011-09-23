From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 22 Sep 2011 22:51:31 -0700
Subject: [PATCH 4/4] ARM: CSR: clock: Fix indentation
In-Reply-To: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
References: <1316757091-14916-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1316757091-14916-5-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
index 615a4e7..aebad7e 100644
--- a/arch/arm/mach-prima2/clock.c
+++ b/arch/arm/mach-prima2/clock.c
@@ -350,10 +350,10 @@ static struct clk_lookup onchip_clks[] = {
 		.clk = &clk_mem,
 	}, {
 		.dev_id = "sys",
-			.clk = &clk_sys,
+		.clk = &clk_sys,
 	}, {
 		.dev_id = "io",
-			.clk = &clk_io,
+		.clk = &clk_io,
 	},
 };
 
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
