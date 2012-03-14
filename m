From: davej@redhat.com (Dave Jones)
Date: Wed, 14 Mar 2012 13:57:03 -0400
Subject: [PATCH v2 RE-SEND] [CPUFREQ] EXYNOS5250: Add support cpufreq for
 EXYNOS5250
In-Reply-To: <4F60D5FE.7080400@samsung.com>
References: <1331377202-25173-1-git-send-email-kgene.kim@samsung.com>
 <4F60D5FE.7080400@samsung.com>
Message-ID: <20120314175703.GA3803@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 10:31:42AM -0700, Kukjin Kim wrote:
 > Kukjin Kim wrote:
 > > From: Jaecheol Lee<jc.lee@samsung.com>
 > > 
 > > This patch adds support cpufreq for EXYNOS5250 SoC. Basically,
 > > the exynos-cpufreq.c is used commonly and exynos5250-cpufreq.c
 > > is used for EXYNOS5250(two Cortex-A15 cores) SoC.
 > > 
 > > Signed-off-by: Jaecheol Lee<jc.lee@samsung.com>
 > > Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
 > 
 > Hi again Dave :)
 > 
 > Please pick up this patch for v3.4.
 > If any problems, please kindly let us know.

this, and the other patch doesn't apply against current cpufreq.git

patching file arch/arm/mach-exynos/include/mach/cpufreq.h
patching file drivers/cpufreq/Kconfig.arm
Hunk #1 succeeded at 30 (offset -17 lines).
Hunk #2 succeeded at 43 (offset -18 lines).
patching file drivers/cpufreq/Makefile
Hunk #1 FAILED at 45.
1 out of 1 hunk FAILED -- saving rejects to file drivers/cpufreq/Makefile.rej
patching file drivers/cpufreq/exynos-cpufreq.c
Hunk #1 succeeded at 252 (offset -2 lines).
patching file drivers/cpufreq/exynos4x12-cpufreq.c
patching file arch/arm/mach-exynos/include/mach/cpufreq.h
Hunk #1 FAILED at 33.
1 out of 1 hunk FAILED -- saving rejects to file arch/arm/mach-exynos/include/mach/cpufreq.h.rej
patching file drivers/cpufreq/Kconfig.arm
Hunk #1 FAILED at 48.
Hunk #2 FAILED at 67.
2 out of 2 hunks FAILED -- saving rejects to file drivers/cpufreq/Kconfig.arm.rej
patching file drivers/cpufreq/Makefile
Hunk #1 FAILED at 46.
1 out of 1 hunk FAILED -- saving rejects to file drivers/cpufreq/Makefile.rej
patching file drivers/cpufreq/exynos-cpufreq.c
Hunk #1 FAILED at 256.
1 out of 1 hunk FAILED -- saving rejects to file drivers/cpufreq/exynos-cpufreq.c.rej
patching file drivers/cpufreq/exynos5250-cpufreq.c

	Dave
