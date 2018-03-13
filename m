From: eric@anholt.net (Eric Anholt)
Date: Tue, 13 Mar 2018 10:30:22 -0700
Subject: [GIT PULL] bcm2835-dt-next-2018-03-13
Message-ID: <20180313173022.30314-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

The following changes since commit bcc76c4014dce4e3834dbd5b7f6593cbcfbfebe0:

  ARM: dts: bcm2835-rpi-zero-w: Enable OTG mode (2018-02-26 15:02:23 -0800)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2018-03-13

for you to fetch changes up to ae67cfc4f6abb379e5bbe9a5616f00b23bbecb01:

  ARM: bcm2835: Add the DPI hardware to the device tree. (2018-03-12 11:44:29 -0700)

----------------------------------------------------------------
This pull request brings in one last patch to add the BCM2835 DPI
controller to the device tree.

----------------------------------------------------------------
Eric Anholt (1):
      ARM: bcm2835: Add the DPI hardware to the device tree.

 arch/arm/boot/dts/bcm283x.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)
