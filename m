From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 May 2014 13:20:48 +0200
Subject: [GIT PULL] Allwinner core for 3.16
Message-ID: <20140516112048.GA18800@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the first of the Allwinner pull requests for the 3.16 merge
window.

Thanks!
Maxime

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-core-for-3.16

for you to fetch changes up to 324da938cb7eb103a925817f9aacdcc1f0e22576:

  ARM: sunxi: select MFD_SUN6I_PRCM when sun6i arch support is enabled (2014-05-15 17:30:07 +0200)

----------------------------------------------------------------
Allwinner SoCs core additions for 3.16

Refactor the Kconfig options to have one Kconfig option per machine.

----------------------------------------------------------------
Boris BREZILLON (1):
      ARM: sunxi: select MFD_SUN6I_PRCM when sun6i arch support is enabled

Maxime Ripard (1):
      ARM: sunxi: Split the various SoCs support in Kconfig

 arch/arm/mach-sunxi/Kconfig | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/eb8d1c1e/attachment.sig>
