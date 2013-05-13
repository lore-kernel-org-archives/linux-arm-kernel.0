From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 16:29:32 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.11 (round 1)
Message-ID: <20130513202932.GE31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/defconfig-3.11-1

for you to fetch changes up to 366c0b76416ed15feb90ba4ef0bd8f03d62d1091:

  ARM: mvebu: Add support for USB storage class in mvebu_defconfig (2013-05-13 20:06:06 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.11 (round 1)

 - mvebu
    - add usb-storage to mvebu_defconfig

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: Add support for USB storage class in mvebu_defconfig

 arch/arm/configs/mvebu_defconfig | 1 +
 1 file changed, 1 insertion(+)
