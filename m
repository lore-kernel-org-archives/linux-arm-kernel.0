From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 13:31:31 +0900
Subject: [GIT PULL] Renesas ARM based SoC defconfig updates for v3.10 #2
Message-ID: <1364877094-1508-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit db30abdf3c07c564d4af0f991bb7f38b728f9035:

  ARM: mach-shmobile: marzen: add SATA support (2013-03-14 10:28:07 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig2-for-v3.10

for you to fetch changes up to 03d409a5c4f8b590caaebd8c99e8977227c3dee7:

  ARM: shmobile: ape6evm: add defconfig (2013-04-01 17:52:07 +0900)

----------------------------------------------------------------
Second round of Renesas ARM based SoC defconfig updates for v3.10

* Add defconfig for ape6evm board
* GPIO updates for marzen

----------------------------------------------------------------
Simon Horman (3):
      ARM: shmobile: marzen: defconfig: add GPIO RCAR driver support
      ARM: shmobile: marzen: defconfig: enable GPIO LEDs driver
      ARM: shmobile: ape6evm: add defconfig

 arch/arm/configs/ape6evm_defconfig |   95 ++++++++++++++++++++++++++++++++++++
 arch/arm/configs/marzen_defconfig  |    4 ++
 2 files changed, 99 insertions(+)
 create mode 100644 arch/arm/configs/ape6evm_defconfig
