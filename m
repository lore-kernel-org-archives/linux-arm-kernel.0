From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Apr 2012 13:29:51 -0600
Subject: [GIT PULL] Tegra fixes for v3.4-rc2
Message-ID: <4F7CA12F.10708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
  Linus Torvalds (1):
        Linux 3.4-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.4/fixes-for-rc2

Stephen Warren (2):
      gpio: tegra: fix register address calculations for Tegra30
      gpio: tegra: Iterate over the correct number of banks

 drivers/gpio/gpio-tegra.c |   59
+++++++++++++++++++++++++++++++++-----------
 1 files changed, 44 insertions(+), 15 deletions(-)
