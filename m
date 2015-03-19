From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 19 Mar 2015 13:45:19 -0500
Subject: [GIT PULL] SoCFPGA late fix for v4.0
Message-ID: <1426790719-21636-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please pull this 1 patch that fixes SPI. If it's too late for v4.0, then
this patch can go in for v4.1.

Thanks,

The following changes since commit 06e5801b8cb3fc057d88cb4dc03c0b64b2744cda:

  Linux 4.0-rc4 (2015-03-15 17:38:20 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_fix_for_v4.0_2

for you to fetch changes up to 1ac31de744202a3a14601170a57f155b4a8d2c21:

  ARM: socfpga: dts: fix spi1 interrupt (2015-03-19 10:51:15 -0500)

----------------------------------------------------------------
Late fix for v4.0 on the SoCFPGA platform:
- Fix interrupt number for SPI1 interface

----------------------------------------------------------------
Mark James (1):
      ARM: socfpga: dts: fix spi1 interrupt

 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
