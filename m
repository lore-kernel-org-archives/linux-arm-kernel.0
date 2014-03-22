From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Mar 2014 22:10:49 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.14
Message-ID: <20140322051049.GA27925@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 10554647b488f58f2c36c78368e9bab4b93da721:

  Merge tag 'omap-for-v3.14/fixes-dt-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes (2014-03-08 22:56:31 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to f656d46bbb2d3ecdb71c998ccf657dccea8d19a9:

  ARM: at91: fix network interface ordering for sama5d36 (2014-03-11 12:49:10 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 3.14

Only two patches this time, one to fix ethernet probe order on at91 (better
fix with proper device aliasing will be done for 3.15, this is stop-gap), and
one update to MAINTAINERS due to Freescale moving their repo to kernel.org.

----------------------------------------------------------------
Boris BREZILLON (1):
      ARM: at91: fix network interface ordering for sama5d36

Shawn Guo (1):
      MAINTAINERS: update IMX kernel git tree

 MAINTAINERS                     | 4 ++--
 arch/arm/boot/dts/sama5d36.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
