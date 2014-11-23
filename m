From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 23 Nov 2014 17:35:54 +0100
Subject: [GIT PULL] Allwinner SimpleFB support for 3.19
Message-ID: <20141123163554.GA5788@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following patches that enable simplefb on most of the
Allwinner SoCs, allowing to finaly be able to have support for a video
display using simplefb as a temp solution.

Thanks,
Maxime

The following changes since commit 109588fd214c930ce6561997250f0eea456a8f7b:

  ARM: dts: sun6i: Add ethernet support to M9 board (2014-11-23 17:00:25 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git sunxi-simplefb-for-3.19

for you to fetch changes up to a9f8cda32a3acc3150755fe973f7fa1867a7a5d6:

  ARM: dts: sunxi: Update simplefb nodes so that u-boot can find them (2014-11-23 17:21:52 +0100)

----------------------------------------------------------------
Allwinner simple frambuffer support

This enables the simple framebuffer on all the supported Allwinner SoCs (but
the A80). That allows to have at last a video display usable by using the
framebuffer the firmware might have set up.

----------------------------------------------------------------
Hans de Goede (6):
      ARM: dts: sun4i: Add simplefb node
      ARM: dts: sun5i: Add simplefb node
      ARM: dts: sun6i: Add simplefb node
      ARM: dts: sun7i: Add simplefb node
      ARM: dts: sunxi: Add de_be0 clk parent pll to simplefb node
      ARM: dts: sunxi: Update simplefb nodes so that u-boot can find them

 arch/arm/boot/dts/sun4i-a10.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi | 14 ++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi  | 12 ++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 14 ++++++++++++++
 4 files changed, 54 insertions(+)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141123/84e5783b/attachment-0001.sig>
