From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 13 Oct 2017 19:32:39 +0530
Subject: [GIT PULL 1/2] DaVinci DT updates for v4.15
Message-ID: <20171013140240.18599-1-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce21574ad1922b403198ee664c4dff276f514f1d:

  ARM: dts: da850-evm: add serial and ethernet aliases (2017-09-20 13:33:41 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.15/dt

for you to fetch changes up to 933311fdfa5f94aeab95d713500fd680523a884a:

  ARM: davinci: da8xx-dt: Add OF_DEV_AUXDATA entry for DSP clock matching (2017-09-20 14:57:56 +0530)

----------------------------------------------------------------
Add support for accessing DSP on DA850 SoC when using
device-tree.

----------------------------------------------------------------
Suman Anna (3):
      ARM: dts: da850: Add DSP node
      ARM: dts: da850-lcdk: Add and enable CMA reserved pool for DSP
      ARM: davinci: da8xx-dt: Add OF_DEV_AUXDATA entry for DSP clock matching

 arch/arm/boot/dts/da850-lcdk.dts | 18 ++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     | 12 ++++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |  1 +
 3 files changed, 31 insertions(+)
