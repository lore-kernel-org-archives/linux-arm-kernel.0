From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 27 Nov 2014 16:06:35 +0900
Subject: [GIT PULL 2/4] Samsung serial updates for v3.19
Message-ID: <5476CD7B.4020808@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin

Please pull this branch for exynos7 SoC into arm-soc.
Note Greg agreed to upstream via arm-soc tree.

Thanks,
Kukjin

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-driver

for you to fetch changes up to edeeec85f7145fe8f2a5ffe250a8ee6b1fe4ab28:

  serial: samsung: Fix serial config dependencies for exynos7
(2014-11-22 00:09:25 +0900)

----------------------------------------------------------------
Samsung driver update for v3.19

- Change samsung serial dependencies for exynos7 (ARMv8)

----------------------------------------------------------------
Pankaj Dubey (1):
      serial: samsung: Fix serial config dependencies for exynos7

 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
