From: patrice.chotard@st.com (Patrice Chotard)
Date: Thu, 20 Oct 2016 17:20:27 +0200
Subject: [GIT PULL] STi defconfig updates for v4.10
Message-ID: <50be6ab2-2af8-b21e-770c-d141d6396179@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd and Kevin,

Please consider this first round of multi_v7_defconfig updates for v4.10 :

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-defconfig-for-4.10

for you to fetch changes up to 620c52f4db4d47e1f33c64e641392fe575d5397f:

  ARM: multi_v7_defconfig: Remove stih41x phy Kconfig symbol. (2016-10-20 17:05:08 +0200)

----------------------------------------------------------------
Remove STiH415/416 specific IPs

As STiH415/416 have been removed from kernel, remove IPs only found
on these socs, remove CONFIG_PHY_MIPHY365X and CONFIG_PHY_STIH41X_USB.

----------------------------------------------------------------
Peter Griffin (2):
      ARM: multi_v7_defconfig: Remove miphy365 phy Kconfig symbol.
      ARM: multi_v7_defconfig: Remove stih41x phy Kconfig symbol.

 arch/arm/configs/multi_v7_defconfig | 2 --
 1 file changed, 2 deletions(-)
