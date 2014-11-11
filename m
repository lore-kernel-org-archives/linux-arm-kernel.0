From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Wed, 12 Nov 2014 00:16:41 +0100
Subject: [GIT PULL] ARM: BCM5301X: SoC changes for v3.19
Message-ID: <546298D9.7080800@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please consider these BCM5301X ARM based SoC soc updates for v3.19.

The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  https://github.com/hauke/linux.git tags/bcm5301x-soc-2014-11-11

for you to fetch changes up to 6f3a612d5ec2b2fd861c21d3c8ad708ffd533925:

  ARM: BCM5301X: select GPIOLIB as optional (2014-11-11 23:49:01 +0100)

----------------------------------------------------------------
ARM: BCM5301X: SoC: two patches for the SoC part

These patches were all send to the arm list and I haven't got any
negative responses.

----------------------------------------------------------------
Hauke Mehrtens (1):
      ARM: BCM5301X: fix early serial console

Rafa? Mi?ecki (1):
      ARM: BCM5301X: select GPIOLIB as optional

 arch/arm/Kconfig.debug    | 4 ++--
 arch/arm/mach-bcm/Kconfig | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)
