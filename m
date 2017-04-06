From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 10:19:04 +0200
Subject: [GIT PULL] Allwinner arm64 config changes for 4.12
Message-ID: <20170406081904.ctvamxa2u4mcavkf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-config64-for-4.12

for you to fetch changes up to 565fbac18efef447a6a97325664c77ddcbe82936:

  arm64: defconfig: add Allwinner USB PHY (2017-03-24 16:43:02 +0100)

----------------------------------------------------------------
Allwinner arm64 config changes for 4.12

Two patches to change our Kconfig option and add new options in the
defconfig.

----------------------------------------------------------------
Andre Przywara (1):
      arm64: defconfig: add Allwinner USB PHY

Icenowy Zheng (1):
      arm64: only select PINCTRL for Allwinner platforms

 arch/arm64/Kconfig.platforms | 1 -
 arch/arm64/configs/defconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/bf1e3f6a/attachment-0001.sig>
