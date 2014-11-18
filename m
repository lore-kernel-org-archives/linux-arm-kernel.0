From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Nov 2014 23:12:57 +0100
Subject: [GIT PULL] Allwinner fixes for 3.18
Message-ID: <20141118221257.GA19248@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is a patch for the 3.18 that fixes the DMA controller operations
on the A31.

Thanks!
Maxime

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-3.18

for you to fetch changes up to 532425a7a7738b479406496ca4ad6b3247688e44:

  ARM: dts: sun6i: Re-parent ahb1_mux to pll6 as required by dma controller (2014-11-08 15:56:36 +0100)

----------------------------------------------------------------
Allwinner fixes for 3.18

A fix for the A31 dma controller that requires the AHB clock to be parented to
PLL6 in order to operate.

----------------------------------------------------------------
Chen-Yu Tsai (1):
      ARM: dts: sun6i: Re-parent ahb1_mux to pll6 as required by dma controller

 arch/arm/boot/dts/sun6i-a31.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/3c2ef800/attachment-0001.sig>
