From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Jul 2016 21:10:58 +0200
Subject: [GIT PULL] Allwinner Fixes for 4.7
Message-ID: <20160704191058.GA29277@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following changes in 4.7.

Thanks!
Maxime

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.7

for you to fetch changes up to eee25ab19de632af1ab4d2ac50bfc5006802e664:

  ARM: dts: sun7i: Fix pll3x2 and pll7x2 not having a parent clock (2016-06-29 09:03:13 +0200)

----------------------------------------------------------------
Allwinner Fixes for 4.7

Two patches fixing simplefb on the SoCs that had their display clocks
enabled, and one fix for the CHIP that will enable its sched clock.

----------------------------------------------------------------
Boris Brezillon (1):
      ARM: sunxi/dt: make the CHIP inherit from allwinner,sun5i-a13

Hans de Goede (2):
      ARM: dts: sunxi: Add pll3 to simplefb nodes clocks lists
      ARM: dts: sun7i: Fix pll3x2 and pll7x2 not having a parent clock

 arch/arm/boot/dts/sun4i-a10.dtsi    | 21 ++++++++++++---------
 arch/arm/boot/dts/sun5i-a10s.dtsi   | 11 ++++++-----
 arch/arm/boot/dts/sun5i-r8-chip.dts |  2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi    | 13 ++++++++-----
 4 files changed, 27 insertions(+), 20 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160704/988d7082/attachment.sig>
