From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 21 Oct 2013 13:41:31 +0100
Subject: [GIT PULL] vexpress: defconfig update for 3.13
Message-ID: <1382359291.3332.7.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings, arm-soc Gentlemen,

The following changes since commit 31d141e3a666269a3b6fcccddb0351caf7454240:

  Linux 3.12-rc6 (2013-10-19 12:28:15 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/defconfig-for-v3.13

for you to fetch changes up to f9255e58d199e4454cc7cb8de50ce01c38403679:

  ARM: vexpress: Enable platform-specific options in defconfig (2013-10-21 11:23:28 +0100)

----------------------------------------------------------------
Update the Versatile Express defconfig in two stages:

1. Make the defconfig-ed kernels actually work on real boards and QEMU.
2. Enable all platform-specific drivers and features.

----------------------------------------------------------------
Fathi Boudra (1):
      ARM: vexpress: Make defconfig work again

Pawel Moll (1):
      ARM: vexpress: Enable platform-specific options in defconfig

 arch/arm/configs/vexpress_defconfig | 73 ++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 26 deletions(-)
