From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 15:56:59 +0800
Subject: [GIT PULL 1/4] Allwinner arm64 defconfig changes for 4.14, round 2
Message-ID: <20170819075659.w2tndblqwhesniuv@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This is the second round of pull requests for Allwinner changes for 4.14.
There were no arm64 defconfig changes in round 1.

Please have a look.

Thanks!
ChenYu

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-config64-for-4.14

for you to fetch changes up to 908d10b02b80a81c5dd1cee88165db2a30e23d45:

  arm64: defconfig: Enable REGULATOR_AXP20X (2017-08-14 15:26:09 +0800)

----------------------------------------------------------------
Allwinner arm64 defconfig changes for 4.14

Enable X-Powers AXP series PMIC mfd and regulator support by default.

----------------------------------------------------------------
Jagan Teki (2):
      arm64: defconfig: Enable MFD_AXP20X_RSB
      arm64: defconfig: Enable REGULATOR_AXP20X

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170819/302341d8/attachment.sig>
