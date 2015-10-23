From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 Oct 2015 20:07:11 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.4, round 3
Message-ID: <20151023180711.GA11749@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following (late and last) pull request for the 4.4
merge window.

Thanks!
Maxime

The following changes since commit c2aa565107fb539a84494fe8dac5fd5eb5678123:

  ARM: dts: sun6i: Add a dts file for the Sinovoip BPI-M2 board (2015-10-17 18:24:11 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.4-3

for you to fetch changes up to a5ea06d0bc123cc7f49d042fab60ddd3964764c8:

  ARM: dts: sun6i: Add dts file for MSI Primo81 tablet (2015-10-23 08:05:17 +0200)

----------------------------------------------------------------
Allwinner DT changes for 4.4, round 3

A bunch of new boards, but mostly enable the support for the Audio Codec
on the older SoCs (A10, A10s, A13, A20, R8) and enable it on various
boards.

----------------------------------------------------------------
Adam Sampson (1):
      ARM: dts: sun7i: Enable USB DRC on pcDuino v3 Nano

Aleksei Mamlin (1):
      ARM: dts: sun4i: Enable audio codec on Marsboard A10.

Chen-Yu Tsai (3):
      ARM: dts: sun6i: Add support for Sinlinx A31s SDK board
      ARM: sun4i: Enable cubieboard audio codec
      ARM: dts: sun6i: Add simplefb node labels to reference at board level

Emilio L?pez (2):
      ARM: sun7i: Add sunxi codec device node
      ARM: sun7i: dt: enable audio codec on Cubietruck

Hans de Goede (1):
      ARM: dts: sun4i: Add dts file for the pov protab2-ips9 tablet

Karsten Merker (1):
      ARM: dts: sun6i: Add dts file for MSI Primo81 tablet

Marcus Cooper (2):
      ARM: sun4i: Add sunxi codec device node
      ARM: sun4i: Enable audio-codec on Mele A1000

Maxime Ripard (9):
      ARM: sun4i: Add audio PLL
      ARM: sun5i: Add audio PLL
      ARM: sun7i: Add audio PLL
      ARM: sun4i: Add audio codec clock
      ARM: sun5i: Add audio codec clock
      ARM: sun7i: Add audio codec clock
      ARM: sun5i: Add the Audio codec DT node
      ARM: sun7i: Enable cubieboard2 audio codec
      ARM: sun5i: chip: Enable the audio codec

 arch/arm/boot/dts/Makefile                       |   5 +-
 arch/arm/boot/dts/sun4i-a10-a1000.dts            |   4 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |   4 +
 arch/arm/boot/dts/sun4i-a10-marsboard.dts        |   4 +
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts | 199 ++++++++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi                 |  31 +++
 arch/arm/boot/dts/sun5i-r8-chip.dts              |   4 +
 arch/arm/boot/dts/sun5i.dtsi                     |  31 +++
 arch/arm/boot/dts/sun6i-a31.dtsi                 |   4 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts         | 255 +++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi   | 140 +++++++++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts         | 153 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |   4 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts       |   4 +
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts    |  19 ++
 arch/arm/boot/dts/sun7i-a20.dtsi                 |  31 +++
 16 files changed, 889 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s.dts

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/d4f51559/attachment.sig>
