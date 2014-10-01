From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 1 Oct 2014 10:34:14 -0400
Subject: [GIT PULL] ARM: dts: Keystone DTS fixes updates for 3.18
Message-ID: <1412174054-25042-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Few DST fixes on top of earlier DTS pull request [1] for 3.18

The following changes since commit b2ed7d98e1c7098f452cf95ab69211a2f8e02ac8:

  ARM: dts: keystone: fix bindings for pcie and usb clock nodes (2014-09-22 15:19:36 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-fixes

for you to fetch changes up to 45aa70d1f77e3b88f776a34cf2b38858d922ca9b:

  ARM: dts: keystone-k2l: fix mdio io start address (2014-10-01 09:59:33 -0400)

----------------------------------------------------------------
Few keystone DTS fixes for 3.18

	- IO range fix for USB phy device
	- Add missing dma-coherent property for K2E USB node
	- Fix K2L MDIO start address
	- Fix K2E MDIO start address

----------------------------------------------------------------
Grygorii Strashko (4):
      ARM: dts: keystone: fix io range for usb_phy0
      ARM: dts: keystone-k2e: update usb1 node for dma properties
      ARM: dts: keystone-k2e: fix mdio io start address
      ARM: dts: keystone-k2l: fix mdio io start address

 arch/arm/boot/dts/k2e.dtsi      |    6 ++++++
 arch/arm/boot/dts/k2l.dtsi      |    4 ++++
 arch/arm/boot/dts/keystone.dtsi |    2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg365571.html 
