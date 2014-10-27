From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 27 Oct 2014 10:48:12 -0500
Subject: [GIT PULL] SOCFPGA defconfig update for v3.19
Message-ID: <1414424892-17519-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

Please consider pulling in this patch for v3.19.

Thanks,
Dinh

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_defconfig_for_v3.19

for you to fetch changes up to 2ca6121c673e1a741f32b6d0857ae48be545d9db:

  ARM: socfpga_defconfig: Update defconfig for SoCFPGA (2014-10-24 16:51:13 -0500)

----------------------------------------------------------------
SOCFPGA defconfig update

Remove extra un-used options in the socfpga_defconfig by doing
"make savedefconfig". Along with this commit, add the configs to enable
support for most filesystems, add regulator and SRAM support, and time
stamps on printk().

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: socfpga_defconfig: Update defconfig for SoCFPGA

 arch/arm/configs/socfpga_defconfig | 71 +++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 43 deletions(-)
