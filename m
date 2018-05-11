From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 11 May 2018 15:31:38 +0100
Subject: [GIT PULL] arm64: defconfig: hisilicon config updates for v4.18
Message-ID: <5AF5A94A.4080308@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

Please help to pull the following changes.

About the CLOCK_STUB and the MAILBOX consolidate patch,
Jassi and Stephen have acked it.
Could you let me know how to handle this kind case
if it is not OK to be in this pull?
Thanks!

Best Regards,
Wei

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.18

for you to fetch changes up to fafb929ce189a84d9915854f3323dded6cbb3e74:

  hisi: Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX (2018-05-11 11:49:31 +0100)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.18

- Sync the arm64 defconfig with savedefconfig
- Enable the support of ethernet, eMMC, Combo/INNO phy
  and PCIe for Hi3798CV200
- Enable the LPC for hip06 and hip07
- Consolidate the configs of the CLOCK_STUB and the MAILBOX
  for hi6220 and hi3660

----------------------------------------------------------------
Daniel Lezcano (1):
      hisi: Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX

John Garry (1):
      arm64: defconfig: Enable HISILICON_LPC

Shawn Guo (2):
      arm64: defconfig: sync it with savedefconfig
      arm64: defconfig: enable drivers for Poplar support

 arch/arm64/configs/defconfig  | 87 ++++++++++++++++++-------------------------
 drivers/clk/hisilicon/Kconfig | 13 ++++---
 drivers/mailbox/Kconfig       | 12 ++++--
 3 files changed, 52 insertions(+), 60 deletions(-)
