From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 08 Oct 2013 12:39:49 +0900
Subject: [PATCH 06/08] ARM: shmobile: Enable PFC/GPIO on the Koelsch board
In-Reply-To: <20131008033851.20455.68845.sendpatchset@w520>
References: <20131008033851.20455.68845.sendpatchset@w520>
Message-ID: <20131008033949.20455.8834.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Enable r8a7791 PFC and GPIO on the Koelsch board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-07 13:46:36.000000000 +0900
@@ -30,6 +30,7 @@
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
+	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
 }
 
