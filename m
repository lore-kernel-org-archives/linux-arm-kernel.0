From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 14 Jul 2014 23:06:56 -0500
Subject: [GIT PULL] SOCFPGA DTS updates for 3.17
Message-ID: <1405397216-909-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling in these 2 patches for v3.17. 1 is just a defconfig
update and the other is a simple DTS fix.

Thanks,
Dinh

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:

  Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_updates_for_3.17

for you to fetch changes up to 7a0385c71fcec129d79ef219eebfcfce16d20417:

  ARM: socfpga: Add missing #reset-cells to socfpga device tree (2014-07-14 22:39:00 -0500)

----------------------------------------------------------------
defconfig and DTS updates for v3.17

----------------------------------------------------------------
Vince Bridgers (2):
      ARM: socfpga: Update socfpga_defconfig
      ARM: socfpga: Add missing #reset-cells to socfpga device tree

 arch/arm/boot/dts/socfpga.dtsi     |    1 +
 arch/arm/configs/socfpga_defconfig |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
