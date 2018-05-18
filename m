From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 18 May 2018 11:58:40 +0100
Subject: [GIT PULL v2] arm64: defconfig: hisilicon config updates for v4.18
Message-ID: <5AFEB1E0.9030200@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

Please help to pull the following changes.
Thanks!

Best Regards,
Wei

---

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://github.com/hisilicon/linux-hisi.git tags/hisi-defconfig-for-4.18v2

for you to fetch changes up to 9ab1c973324566baa314f8dd4e3827e4076a8675:

  arm64: defconfig: Enable HISILICON_LPC (2018-05-11 11:39:01 +0100)

----------------------------------------------------------------
ARM64: hisilicon: defconfig updates for 4.18

- Sync the arm64 defconfig with savedefconfig
- Enable the support of ethernet, eMMC, Combo/INNO phy
  and PCIe for Hi3798CV200
- Enable the LPC for hip06 and hip07

----------------------------------------------------------------
John Garry (1):
      arm64: defconfig: Enable HISILICON_LPC

Shawn Guo (2):
      arm64: defconfig: sync it with savedefconfig
      arm64: defconfig: enable drivers for Poplar support

 arch/arm64/configs/defconfig | 86 +++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 50 deletions(-)
