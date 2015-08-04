From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 04 Aug 2015 16:30:18 +0900
Subject: [GIT PULL 5/5] Samsung driver updates for v4.3
Message-ID: <55C06A0A.6040407@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This branch is including to support generic cpufreq driver in
mach-exynos dir. for exynos3250 and exynos5250 even the tag name is
driver. Because it is depending on clk and cpufreq changes which acked
by regarding maintainers, Mike and Viresh.

Please pull and if any problems, please kindly let me know.

Thanks,
Kukjin

The following changes since commit 995008abdf5146feb0ffdeb15ddb0e90010aff50:

  Merge branch 'v4.3-next/dt-samsung-2' into
v4.3-next/clk-cpufreq-samsung (2015-08-04 15:59:14 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-driver

for you to fetch changes up to 6b1621c4a15b9110cda7cc2e2eb3e8e1a0c2bcfc:

  ARM: EXYNOS: Add exynos3250 compatible to use generic cpufreq driver
(2015-08-04 15:59:33 +0900)

----------------------------------------------------------------
Samsung mach-exynos and driver updates for v4.3

- Use generic cpufreq driver for exynos3250 and exynos5250
  : note depends on the following
    v4.3-topic/clk-samsung (acked by clk maintainer, Mike)
    v4.3-topic/cpufreq-samsung (acked by cpufreq maintainer, Viresh)
    v4.3-next/dt-samsung-2 (add CPU OPP and regulator supply)

----------------------------------------------------------------
Chanwoo Choi (1):
      ARM: EXYNOS: Add exynos3250 compatible to use generic cpufreq driver

Thomas Abraham (1):
      ARM: EXYNOS: switch to using generic cpufreq driver for exynos5250

 arch/arm/mach-exynos/exynos.c | 2 ++
 1 file changed, 2 insertions(+)
