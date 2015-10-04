From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 4 Oct 2015 15:46:19 +0200
Subject: [GIT PULL] Allwinner Fixes for 4.3, round 1
Message-ID: <20151004134619.GA9006@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following commits for one of the 4.3-rc's.

Thanks!
Maxime

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.3

for you to fetch changes up to f594297830b29c8204c421fafe66001178ac0f9a:

  ARM: dts: Fix Makefile target for sun4i-a10-itead-iteaduino-plus (2015-09-13 14:20:26 +0200)

----------------------------------------------------------------
Allwinner fixes for 4.3

Two patches, one that fixes one of the DT build, and the other raising the
voltage of the lowest OPP of the A20 to remain within the SoC operating
boundaries

----------------------------------------------------------------
Josh Boyer (1):
      ARM: dts: Fix Makefile target for sun4i-a10-itead-iteaduino-plus

Timo Sigurdsson (1):
      ARM: dts: sunxi: Raise minimum CPU voltage for sun7i-a20 to meet SoC specifications

 arch/arm/boot/dts/Makefile       | 2 +-
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151004/b4e391fb/attachment.sig>
