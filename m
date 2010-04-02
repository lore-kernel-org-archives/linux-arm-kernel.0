From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 02 Apr 2010 08:48:52 +0200
Subject: [PATCH 04/16] ARM: S5PC100: copy clocks from plat-s5pc1xx
In-Reply-To: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1270190944-21644-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare for moving support for S5PC100 SoC to plat-s5p framework (part 2). Copy
clocks definition to mach-s5pc100 directory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../s5pc100-clock.c => mach-s5pc100/clock.c}       |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 copy arch/arm/{plat-s5pc1xx/s5pc100-clock.c => mach-s5pc100/clock.c} (100%)

diff --git a/arch/arm/plat-s5pc1xx/s5pc100-clock.c b/arch/arm/mach-s5pc100/clock.c
similarity index 100%
copy from arch/arm/plat-s5pc1xx/s5pc100-clock.c
copy to arch/arm/mach-s5pc100/clock.c
-- 
1.6.4
