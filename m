From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed,  5 Aug 2015 10:44:41 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.3 (part 2)
Message-ID: <1438796683-18581-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ee224e175e9d837b3d572e863ac96109b58707ac:

  Merge tag 'mvebu-dt-4.3-2' of git://git.infradead.org/linux-mvebu into next/dt (2015-08-05 11:10:30 +0200)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.3/dts-part2

for you to fetch changes up to 62c5fd2c319ae72e82abc3de689d8a8a4df5a3e9:

  ARM: dts: brcmstb: add BCM7445 GPIO nodes (2015-08-05 10:20:23 -0700)

----------------------------------------------------------------
This pull requests contains the following changes:

- Hauke enables additional I and D cache line prefetching for the BCM5301X L2
  cache controller (PL310)

- Felix adds the Cortex-A9 PMU DT nodes to allow profiling on BCM53101X

- Gregory adds L2 interrupt controllers and GPIO nodes to the reference BCM7445
  Device Tree include file

----------------------------------------------------------------
Felix Fietkau (1):
      ARM: BCM5301X: Add profiling support

Gregory Fong (1):
      ARM: dts: brcmstb: add BCM7445 GPIO nodes

Hauke Mehrtens (1):
      ARM: BCM5301X: activate some additional options in pl310 cache controller

 arch/arm/boot/dts/bcm5301x.dtsi | 10 +++++++++
 arch/arm/boot/dts/bcm7445.dtsi  | 50 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)
