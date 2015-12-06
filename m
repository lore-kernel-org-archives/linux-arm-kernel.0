From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  6 Dec 2015 11:37:11 +0100
Subject: [GIT PULL 2/3] ARM64: berlin: SoC changes for v4.5 (round 1)
In-Reply-To: <1449398232-13699-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1449398232-13699-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1449398232-13699-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is the first round of Marvell Berlin64 SoC changes for v4.5.
With pinctrl available, we just select PINCTRL Kconfig for 64-bit Berlin.

Please pull.

Sebastian

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin64-soc-for-4.5-1

for you to fetch changes up to 75d8e1baa5e086de02b9be1ae3eaeb591adc6cf0:

  arm64: berlin: add the pinctrl dependency for Marvell Berlin SoCs (2015-11-19 21:07:11 +0100)

----------------------------------------------------------------
Marvell Berlin64 SoC changes (round 1):
- add PINCTRL dependency

----------------------------------------------------------------
Jisheng Zhang (1):
      arm64: berlin: add the pinctrl dependency for Marvell Berlin SoCs

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
