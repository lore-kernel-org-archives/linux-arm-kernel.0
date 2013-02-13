From: sourav.poddar@ti.com (Sourav Poddar)
Date: Wed, 13 Feb 2013 14:58:00 +0530
Subject: [PATCH 0/5] omap[4/5] I2c/Spi dts patches
Message-ID: <1360747680-1438-1-git-send-email-sourav.poddar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony, 

These patches were send as seperate ones before[1], but did not recieve any 
comments. Resending them all as a single patch series, as some affect the same files.
[1]: https://patchwork.kernel.org/patch/2054891/
     https://patchwork.kernel.org/patch/2054871/ 
     https://patchwork.kernel.org/patch/2070991/ 	
     https://patchwork.kernel.org/patch/2089751/
     http://www.spinics.net/lists/linux-omap/msg86137.html	 

If you are Ok with the patch and there are no comments, Can it be picked?
	
The following changes since commit 6edacf05c8362f4c368991b55d85e8122cfc9a24:

  Merge branch 'merge' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2013-02-04 16:58:41 +1100)

are available in the git repository at:

  git at gitorious.org:linux-connectivity/linux-connectivity.git spi_i2c_dev

Felipe Balbi (1):
      arm: dts: omap5: add SPI devices to OMAP5 DeviceTree file

Sourav Poddar (4):
      arm: dts: omap4-sdp: Add I2c pinctrl data
      arm: dts: omap5-evm: Add I2c pinctrl data
      arm: dts: omap4-panda: Add I2c pinctrl data
      arm: dts: omap5-evm: Add mcspi data

 arch/arm/boot/dts/omap4-panda.dts |   40 ++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   40 ++++++++++++++
 arch/arm/boot/dts/omap5-evm.dts   |  108 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi      |   40 ++++++++++++++
 4 files changed, 228 insertions(+), 0 deletions(-)
