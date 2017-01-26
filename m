From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 26 Jan 2017 17:27:54 +0100
Subject: [GIT PULL] ARM: at91: dt for 4.11 #2
Message-ID: <20170126162754.rn2kj6ecser5tzyq@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Two non urgent fixes for 4.11 that could hopefully be backported as far
back as possible to make kernelci (and our users) happy.

The following changes since commit 21dd0ece34c2a07432a1cd0bbcb4815ce2b49173:

  ARM: dts: at91: add devicetree for the Axentia TSE-850 (2017-01-10 16:16:33 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-dt2

for you to fetch changes up to 78162d48466d23c45a784034630c5928af631e3d:

  ARM: dts: at91: Enable DMA on sama5d2_xplained console (2017-01-23 00:33:43 +0100)

----------------------------------------------------------------
DT for 4.11 #2:

 - Enable the DMA on sama5d2 and sama5d4 xplained to fix an issue seen by
 kernelci

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: dts: at91: Enable DMA on sama5d4_xplained console
      ARM: dts: at91: Enable DMA on sama5d2_xplained console

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
 arch/arm/boot/dts/at91-sama5d4_xplained.dts | 2 ++
 2 files changed, 4 insertions(+)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
