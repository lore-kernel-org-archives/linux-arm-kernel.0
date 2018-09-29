From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 16:13:55 +0200
Subject: [GIT PULL] Allwinner arm64 config changes for 4.20
Message-ID: <20180929141355.qmv4edkkfavueeei@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are our arm64 defconfig changes for the next merge window.

Thanks!
Maxime

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-config64-for-4.20

for you to fetch changes up to 0570921c4c32e88a2f6102c476313eaa51c4842a:

  arm64: defconfig: Enable CONFIG_DRM_SUN4I (2018-09-05 09:04:38 +0200)

----------------------------------------------------------------
Allwinner arm64 config changes for 4.20

Here is a single config change to enable the DRM driver in the arm64
defconfig.

----------------------------------------------------------------
Jagan Teki (1):
      arm64: defconfig: Enable CONFIG_DRM_SUN4I

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180929/816bb5b5/attachment.sig>
