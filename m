From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 4 Apr 2017 14:55:46 +0530
Subject: [GIT PULL 3/4] DaVinci DT updates for v4.12 (part 2)
In-Reply-To: <20170404092547.32480-1-nsekhar@ti.com>
References: <20170404092547.32480-1-nsekhar@ti.com>
Message-ID: <20170404092547.32480-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f8914131f7da23ab604efd8d1b95a416e5d8fc44:

  ARM: dts: da850-evm: add the output port to the vpif node (2017-03-07 16:46:56 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/dt-2

for you to fetch changes up to 96f24474a82635810be6943f1bd3fb9c1b70d9d0:

  ARM: dts: da850: move spi0_cs3_pin pinconf node (2017-03-30 16:17:47 +0530)

----------------------------------------------------------------
A clean-up device-tree patch to ensure
pinmux entry reuse.

----------------------------------------------------------------
David Lechner (1):
      ARM: dts: da850: move spi0_cs3_pin pinconf node

 arch/arm/boot/dts/da850-lego-ev3.dts | 7 -------
 arch/arm/boot/dts/da850.dtsi         | 6 ++++++
 2 files changed, 6 insertions(+), 7 deletions(-)
