From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Nov 2016 15:47:31 +0100
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.10, bis
Message-ID: <20161122144731.c6q6jxgd7cyeieqr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here is a second run at the arm64 PR I sent earlier.

We had a (build) dependency against the clock patches that have been
merged by Stephen and Mike through the clock tree.

Hence, this new PR is based on top of the tag I sent their way, and it
supersedes the previous arm64 PR.

I used this occasion to rename the patches prefix as Olof suggested in
the earlier pull request.

Thanks,
Maxime

The following changes since commit 0f6f9302b819ca352cfd4f42c18ec08d521f9cae:

  clk: sunxi-ng: sun8i-h3: Set CLK_SET_RATE_PARENT for audio module clocks (2016-11-11 21:47:41 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt64-for-4.10-bis

for you to fetch changes up to 5757867e8758f40227e710625df64a471ec81411:

  arm64: dts: allwinner: add Pine64 support (2016-11-22 15:43:01 +0100)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.10, bis

Support for the Allwinner A64, their first armv8 SoC.

----------------------------------------------------------------
Andre Przywara (3):
      arm64: dts: allwinner: add Allwinner A64 SoC .dtsi
      Documentation: devicetree: add vendor prefix for Pine64
      arm64: dts: allwinner: add Pine64 support

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  50 ++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  74 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 263 +++++++++++++++++++++
 8 files changed, 396 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161122/3b840c1a/attachment.sig>
