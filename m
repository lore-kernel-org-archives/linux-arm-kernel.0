From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 11:09:55 +0100
Subject: [GIT PULL] Allwinner fixes for 4.11
Message-ID: <20170320100955.qiq4nhfgkdqsce7j@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following patches for one of the 4.11 rc's.

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.11

for you to fetch changes up to 9693219aa61dc7a75ac015e5c011e889cb821eec:

  ARM: sun8i: a23/a33: drop bl_en_pin GPIO pinmux in reference design DTSI (2017-03-20 09:31:42 +0100)

----------------------------------------------------------------
Allwinner fixes for 4.11

A bunch of device tree fixes for various boards / SoCs.

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: dts: sun7i: lamobo-r1: Fix CPU port RGMII settings

Icenowy Zheng (1):
      ARM: sun8i: a23/a33: drop bl_en_pin GPIO pinmux in reference design DTSI

Maxime Ripard (1):
      ARM: sun8i: Fix the mali clock rate

 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts            | 2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                 | 2 +-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 7 -------
 3 files changed, 2 insertions(+), 9 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/52772a4e/attachment.sig>
