From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 May 2016 22:28:37 +0200
Subject: [GIT PULL] Allwinner DT for 4.7, round 2
Message-ID: <20160509202837.GA19124@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here's a second bunch of patches for DT, that is on top of the previous PR.

Unless something unexpected comes up, I expect it to be our last PR
for the 4.7 merge window.

Thanks!
Maxime

The following changes since commit b52e345d43cfe9214fecfa92375525a086d39581:

  ARM: dts: sun7i: Enable S/PDIF on the Cubietruck (2016-04-25 09:56:34 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.7-2

for you to fetch changes up to 068655dc9b7c71c4bea25c41eeaa5125c6724a91:

  ARM: sun7i: dt: Add pll3 and pll7 clocks (2016-05-08 21:09:29 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.7, round 2

Mostly DT patches to enable the new DRM driver on the CHIP, preliminary
support for the A10 and A20, and a support for a new variant of the Olimex
A20-Olinuxino-Lime2 featuring an eMMC

----------------------------------------------------------------
Maxime Ripard (3):
      ARM: sun5i: a13: Add display and TCON clocks
      ARM: sun5i: r8: Add display blocks to the DTSI
      ARM: sun5i: chip: Enable the TV Encoder

Olliver Schinagl (1):
      ARM: dts: sunxi: Add a olinuxino-lime2-emmc

Priit Laes (2):
      ARM: sun4i: dt: Add pll3 and pll7 clocks
      ARM: sun7i: dt: Add pll3 and pll7 clocks

 arch/arm/boot/dts/sun4i-a10.dtsi                   |  43 +++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  39 +++++-
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  12 ++
 arch/arm/boot/dts/sun5i-r8.dtsi                    | 142 ++++++++++++++++++++-
 .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts    |  82 ++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  41 ++++++
 6 files changed, 355 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160509/d17318ab/attachment.sig>
