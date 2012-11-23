From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Nov 2012 08:30:25 -0800
Subject: [GIT PULL] ARM: SoC fixes for 3.7 (one more)
Message-ID: <20121123163025.GA24140@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I had missed one pull request in the batch you merged yesterday. Better
keep them small and frequent at this point, so here it is.

The following changes since commit 5a903166dd31a42e39283b075cc6b9a9c079d1af:

  Merge tag 'fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-11-22 09:22:13 -1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to c667f757f392aa7b4d87374b2a975dce8c6186d1:

  Merge branch 'v3.7-samsung-fixes-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into fixes (2012-11-22 20:43:37 -0800)

----------------------------------------------------------------

ARM: SoC fixes for 3.7

I missed one pull request from Samsung with one fix in the previous
batch. Here it is -- a dma driver fix for an early version of silicon
that they still support.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of Exynos4210 SOC

Olof Johansson (1):
      Merge branch 'v3.7-samsung-fixes-3' of git://git.kernel.org/.../kgene/linux-samsung into fixes

 arch/arm/mach-exynos/dma.c              | 3 +++
 arch/arm/mach-exynos/include/mach/map.h | 1 +
 2 files changed, 4 insertions(+)
