From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 15 Jan 2014 11:04:49 -0600
Subject: [GIT PULL] SOCFPGA DT updates for 3.14 - take 2
Message-ID: <1389805489-13968-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

Please consider pulling in this 1 patch for the SOCFPGA DT patch for v3.14.

Thanks,
Dinh

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-dt-for-3.14-take-2

for you to fetch changes up to 9cd20af9ccdf947a12518d36627dd46674784288:

  dts: socfpga: Add support for SD/MMC on the SOCFPGA platform (2014-01-15 07:15:49 -0600)

----------------------------------------------------------------
SOCFPGA DT updates for v3.14 - take 2

----------------------------------------------------------------
Dinh Nguyen (1):
      dts: socfpga: Add support for SD/MMC on the SOCFPGA platform

 arch/arm/boot/dts/socfpga.dtsi          |   13 ++++++++++++-
 arch/arm/boot/dts/socfpga_arria5.dtsi   |   11 +++++++++++
 arch/arm/boot/dts/socfpga_cyclone5.dtsi |   11 +++++++++++
 arch/arm/boot/dts/socfpga_vt.dts        |   11 +++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)
