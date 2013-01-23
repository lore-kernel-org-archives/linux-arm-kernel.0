From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 02:48:08 +0000
Subject: [GIT PULL V2 3/4] ARM: mvebu: boards for v3.9
In-Reply-To: <1358909281.35276e0.21555@triton>
Message-ID: <1358909288.DEcceb2a3.21555@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 43076a4c4e5fb92721bedc5d05b93468d6d76b2c:

  mmc: mvsdio: add pinctrl integration (2013-01-23 01:42:29 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/boards_for_v3.9

for you to fetch changes up to 6c00ce51dd26ffcd978c657533a71af32dbf2793:

  arm: mvebu: enable btmrvl driver in mvebu_defconfig (2013-01-23 01:57:37 +0000)

----------------------------------------------------------------
mvebu boards for v3.9
 - Guruplug Server Plus DT board
 - mvebu improved SMP support in interrupt controller
 - update mvebu_defconfig

depends on:
 - mvebu/fixes
 - mvebu/drivers

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm: mvebu: Update defconfig with Marvell RTC support

Thomas Petazzoni (3):
      arm: mvebu: enable SDIO support in mvebu_defconfig
      arm: mvebu: enable mwifiex driver in mvebu_defconfig
      arm: mvebu: enable btmrvl driver in mvebu_defconfig

 arch/arm/configs/mvebu_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)
