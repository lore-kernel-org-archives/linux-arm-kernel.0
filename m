From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Sep 2016 23:19:57 +0200
Subject: [GIT PULL] Allwinner arm64 config changes for 4.9
Message-ID: <20160911211957.GA20927@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following patch for the next merge window.

Thanks!
Maxime

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-config64-for-4.9

for you to fetch changes up to d229d205132bfd75fa0cf36fce24264ed01de28a:

  arm64: sunxi: Kconfig: add essential pinctrl driver (2016-08-23 21:37:17 +0200)

----------------------------------------------------------------
Allwinner ARM64 Kconfig changes

Select the pinctrl driver in kconfig

----------------------------------------------------------------
Andre Przywara (1):
      arm64: sunxi: Kconfig: add essential pinctrl driver

 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160911/ae4db3b7/attachment-0001.sig>
