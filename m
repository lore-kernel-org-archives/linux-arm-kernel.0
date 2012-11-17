From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 21:02:37 -0700
Subject: [GIT PULL 3/3] ARM: bcm2835: defconfig updates
In-Reply-To: <1353124957-23808-1-git-send-email-swarren@wwwdotorg.org>
References: <1353124957-23808-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1353124957-23808-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

procfs and sysfs are enabled in bcm2835_defconfig.

----------------------------------------------------------------

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git bcm2835-for-3.8-defconfig

for you to fetch changes up to a6380c13c112af5122b8284c8cf1ec09aacae81d:

  ARM: bcm2835: enable procfs and sysfs in defconfig

----------------------------------------------------------------

Thomas Petazzoni (1):
      ARM: bcm2835: enable procfs and sysfs in defconfig

 arch/arm/configs/bcm2835_defconfig |    2 --
 1 file changed, 2 deletions(-)
