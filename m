From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:10:57 +0100
Subject: [GIT PULL] Allwinner fixes for 4.9
Message-ID: <20161115211057.3b2c35l6pxspzzkp@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Arnd, Olof,

Please pull the following changes for 4.9.

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.9

for you to fetch changes up to b7f865ede20c87073216f77fe97f6fc56666e3da:

  ARM: dts: sun8i: fix the pinmux for UART1 (2016-10-25 12:51:06 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.9

A fix to reintroduce missing pinmux options that turned out not to be
optional.

----------------------------------------------------------------
Icenowy Zheng (1):
      ARM: dts: sun8i: fix the pinmux for UART1

 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/e2a8bfc4/attachment.sig>
