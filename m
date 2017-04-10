From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Apr 2017 23:21:04 +0800
Subject: [GIT PULL 1/2] ZTE driver updates for 4.12
Message-ID: <1491837665-2579-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-drivers-4.12

for you to fetch changes up to 71ce8430348f989d0c78871828d96e0e616056dd:

  soc: zte: pm_domains: Remove .owner field for driver (2017-03-08 12:40:44 +0100)

----------------------------------------------------------------
ZTE driver updates for 4.12:

It includes a couple of small cleanups on zx296718 power domain drivers.

----------------------------------------------------------------
Wei Yongjun (2):
      soc: zte: pm_domains: Remove redundant dev_err call in zx2967_pd_probe()
      soc: zte: pm_domains: Remove .owner field for driver

 drivers/soc/zte/zx296718_pm_domains.c | 1 -
 drivers/soc/zte/zx2967_pm_domains.c   | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)
