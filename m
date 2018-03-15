From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 15 Mar 2018 19:36:35 +0800
Subject: [GIT PULL 1/6] i.MX drivers updates for 4.17
Message-ID: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.17

for you to fetch changes up to f40a1e3705be23e845fbeec66acf3a6582524145:

  soc: imx: gpc: ARM power domain should be always-on (2018-02-12 13:07:48 +0800)

----------------------------------------------------------------
i.MX drivers update for 4.17:
 - Set GENPD_FLAG_ALWAYS_ON flag for ARM power domain to avoid incorrect
   power state in sysfs pm_genpd_summary output.

----------------------------------------------------------------
Anson Huang (1):
      soc: imx: gpc: ARM power domain should be always-on

 drivers/soc/imx/gpc.c | 1 +
 1 file changed, 1 insertion(+)
