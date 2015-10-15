From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 09:34:15 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.4
Message-ID: <cover.1444868963.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates for v4.4.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.4,
which I have already sent a pull-request for.


The following changes since commit 0877098d82fd1823878534b116a4a725e729701f:

  ARM: shmobile: porter: add Ether DT support (2015-10-06 09:44:53 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.4

for you to fetch changes up to 99f7445ea41c0187cd2e78bcb58cdd9e6c1756e5:

  ARM: shmobile: porter: enable internal PCI and USB PHY (2015-10-13 10:00:12 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.4

* Enable the following on the porter board:
  I2C2, PCI, PCIe, QSPI, SATA0, SDHI0/2, USB PHY and VIN0/ADV7180.

----------------------------------------------------------------
Sergei Shtylyov (7):
      ARM: shmobile: porter: add SDHI0/2 DT support
      ARM: shmobile: porter: enable SATA0
      ARM: shmobile: porter: add I2C2 DT support
      ARM: shmobile: porter: add VIN0/ADV7180 DT support
      ARM: shmobile: porter: add QSPI DT support
      ARM: shmobile: porter: enable PCIe
      ARM: shmobile: porter: enable internal PCI and USB PHY

 arch/arm/boot/dts/r8a7791-porter.dts | 202 +++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)
