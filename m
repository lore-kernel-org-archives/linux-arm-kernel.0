From: t.dakhran@gmail.com (Tarek Dakhran)
Date: Sun, 17 May 2015 09:42:02 +0300
Subject: [PATCH v1 0/1] fix DEBUG_LL on Cortex-A7.
Message-ID: <1431844923-4654-1-git-send-email-t.dakhran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When system boots from Cortex-A7 addruart loads
wrong base UART address. This patch fixex problem.

Patch tested on Hardkernel Odroid-XU3 board
on linux kernel v4.0.

Tarek Dakhran (1):
  ARM: EXYNOS: fix DEBUG_LL on Cortex-A7.

 arch/arm/include/debug/exynos.S | 1 +
 1 file changed, 1 insertion(+)

-- 
1.9.1
