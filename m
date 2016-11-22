From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Nov 2016 15:31:34 +0100
Subject: [GIT PULL] Allwinner fixes for 4.9, take 2
Message-ID: <20161122143134.wxinkyp3x6jjnk7e@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please find attached a commit to rename the GR8 device trees.

Thanks!
Maxime

The following changes since commit b7f865ede20c87073216f77fe97f6fc56666e3da:

  ARM: dts: sun8i: fix the pinmux for UART1 (2016-10-25 12:51:06 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.9-2

for you to fetch changes up to e5cd7ff7058dc6f2133455636809a09b691ee419:

  ARM: gr8: Rename the DTSI and relevant DTS (2016-11-22 15:06:04 +0100)

----------------------------------------------------------------
Allwinner fixes for 4.9, second iteration

A renaming of the GR8 DTSI and DTS to make it explicitly part of the sun5i
family.

----------------------------------------------------------------
Maxime Ripard (1):
      ARM: gr8: Rename the DTSI and relevant DTS

 arch/arm/boot/dts/Makefile                               | 2 +-
 arch/arm/boot/dts/{ntc-gr8-evb.dts => sun5i-gr8-evb.dts} | 2 +-
 arch/arm/boot/dts/{ntc-gr8.dtsi => sun5i-gr8.dtsi}       | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{ntc-gr8-evb.dts => sun5i-gr8-evb.dts} (99%)
 rename arch/arm/boot/dts/{ntc-gr8.dtsi => sun5i-gr8.dtsi} (100%)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161122/b6f72872/attachment.sig>
