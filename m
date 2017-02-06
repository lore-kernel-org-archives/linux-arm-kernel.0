From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 13:50:41 +0100
Subject: [GIT PULL] Allwinner DT changes for 4.11, part 2
Message-ID: <20170206125041.iswtdtw2v6vfbus4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is a new pull request for our DT patches that comes on top of the
previous one.

I expect it to be our last pull request for the 4.11 merge window.

Thanks!
Maxime

The following changes since commit ef09e0f539f124c67aa44d4154730bc8492196bf:

  ARM: dts: sun8i-h3: Add SPDIF to the Beelink X2 (2017-01-27 21:09:58 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-4.11-2

for you to fetch changes up to da2ee97311486063e86e7989b713ec6aca66ca3e:

  ARM: dts: sun8i: sinlinx: Enable audio nodes (2017-02-06 08:48:18 +0100)

----------------------------------------------------------------
Allwinner DT changes for 4.11, part 2

Support for the audio codec and Mali GPU for the A33

----------------------------------------------------------------
Maxime Ripard (2):
      dt-bindings: gpu: Add Mali Utgard bindings
      ARM: sun8i: dt: Add mali node

Myl?ne Josserand (3):
      ARM: dts: sun8i: Add audio codec, dai and card for A33
      ARM: dts: sun8i: parrot: Enable audio nodes
      ARM: dts: sun8i: sinlinx: Enable audio nodes

 .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 81 ++++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               | 26 +++++++
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     | 12 ++++
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 45 ++++++++++++
 arch/arm/boot/dts/sun8i-r16-parrot.dts             | 12 ++++
 5 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/80bfd1a8/attachment.sig>
