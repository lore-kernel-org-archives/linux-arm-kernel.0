From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 15:48:30 -0800
Subject: [GIT PULL 1/2] Broadcom drivers changes for 4.20 part 2
Message-ID: <20181105234831.30526-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.20/drivers-part2

for you to fetch changes up to 0810d5cc29a1e4bb9e738a478b746aebf8dc1931:

  bus: brcmstb_gisb: simplify getting .driver_data (2018-11-05 12:37:22 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM/ARM64/MIPS SoCs drivers changes
for 4.20:

- Wolfram converts the Broadcom STB GISB bus arbiter driver to use
  dev_get_drvdata()

- Florian fixes the kernel's re-entry point function when the kernel is
  built with CONFIG_THUMB2_KERNEL

----------------------------------------------------------------
Florian Fainelli (1):
      soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL

Wolfram Sang (1):
      bus: brcmstb_gisb: simplify getting .driver_data

 drivers/bus/brcmstb_gisb.c          | 12 ++++--------
 drivers/soc/bcm/brcmstb/pm/pm-arm.c |  2 +-
 2 files changed, 5 insertions(+), 9 deletions(-)
