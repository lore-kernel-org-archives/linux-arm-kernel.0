From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 26 Aug 2013 11:20:28 +0200
Subject: [GIT PULL] Allwinner sunXi DT additions for 3.12, take 4
Message-ID: <20130826092028.GA5109@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following tag on top of the one I previously sent you.

Thanks!
Maxime

The following changes since commit 82abe5294aeadc42508c7944f3a9aec0eece214c:

  ARM: sun7i: Add Cubieboard2 Device Tree (2013-08-22 00:19:19 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-dt-for-3.12-4

for you to fetch changes up to de7dc935557b0b5fcfe4a9c4802f51e3e9cb8d45:

  ARM: sun7i: Enable the A20 clocks in the DTSI (2013-08-26 10:51:19 +0200)

----------------------------------------------------------------
Allwinner DT changes for 3.12, take 4

These patches enables the gated clocks on the A10s, A20 and A31 DTSI.

----------------------------------------------------------------
Maxime Ripard (3):
      ARM: sun5i: dt: Use the A10s gates in the DTSI
      ARM: sun6i: Enable clock support in the DTSI
      ARM: sun7i: Enable the A20 clocks in the DTSI

 arch/arm/boot/dts/sun5i-a10s.dtsi |  36 ++++------
 arch/arm/boot/dts/sun6i-a31.dtsi  | 144 +++++++++++++++++++++++++++++++++++---
 arch/arm/boot/dts/sun7i-a20.dtsi  | 126 ++++++++++++++++++++++++++++++---
 3 files changed, 264 insertions(+), 42 deletions(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130826/accff777/attachment.sig>
