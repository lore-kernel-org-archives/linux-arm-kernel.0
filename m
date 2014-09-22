From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 23 Sep 2014 00:41:24 +0200
Subject: [GIT PULL] ARM: berlin: SoC changes for v3.18
In-Reply-To: <1411425685-27276-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411425685-27276-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411425685-27276-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing scary in here, just select the new reset driver.

Please pull,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-soc-for-3.18-1

for you to fetch changes up to 95ef63ffb4a027a1e74a6225a0feca3c1a6984ec:

  ARM: Berlin: select the reset controller (2014-09-11 23:01:24 +0200)

----------------------------------------------------------------
Just select the new reset driver for Marvell Berlin SoCs.

----------------------------------------------------------------
Antoine Tenart (1):
      ARM: Berlin: select the reset controller

 arch/arm/mach-berlin/Kconfig | 2 ++
 1 file changed, 2 insertions(+)
