From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 6 Apr 2017 11:06:06 +0200
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.12
Message-ID: <20170406090606.uc5aucn5ixinkdiu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.12

for you to fetch changes up to ec4279053a6434f685246e022be95d2a62f8c608:

  arm64: allwinner: a64: add R_PIO pinctrl node (2017-04-04 17:45:09 +0200)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.12

Some patches to enable the PRCM block in the A64

----------------------------------------------------------------
Icenowy Zheng (2):
      arm64: allwinner: a64: add r_ccu node
      arm64: allwinner: a64: add R_PIO pinctrl node

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 29 +++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/8dabc1c2/attachment.sig>
