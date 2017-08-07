From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Aug 2017 11:19:10 +0800
Subject: [GIT PULL 1/3] Allwinner defconfig changes for 4.14
Message-ID: <20170807031910.66qj742m3egmdex5@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is the first round of Allwinner pull requests for 4.14.
This one is for the defconfigs. Please have a look and merge
if nothing stands out.

Thanks
ChenYu


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-defconfig-for-4.14

for you to fetch changes up to a679e5f52d0209789eb3f542d857a4ead2e85167:

  arm: sunxi: Add AXP20X_ADC (2017-07-24 11:39:02 +0200)

----------------------------------------------------------------
Allwinner defconfig changes for 4.14

Sunxi_defconfig is refreshed and various power supply and ADC drivers
of the AXP PMICs have been enabled.

----------------------------------------------------------------
Maxime Ripard (3):
      arm: sunxi: refresh the defconfig
      arm: sunxi: Add additional power supplies
      arm: sunxi: Add AXP20X_ADC

 arch/arm/configs/sunxi_defconfig | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170807/b3b391c8/attachment.sig>
