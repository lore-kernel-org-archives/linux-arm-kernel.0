From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Jun 2017 17:50:29 +0530
Subject: [GIT PULL 2/2] DaVinci defconfig updates for v4.13 (part 2)
In-Reply-To: <20170616122029.27623-1-nsekhar@ti.com>
References: <20170616122029.27623-1-nsekhar@ti.com>
Message-ID: <20170616122029.27623-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0b997c8c9562dd61733dfeb9e1a5962730338e6e:

  ARM: davinci_all_defconfig: Enable CPPI 4.1 USB OTG DMA (2017-05-30 16:12:51 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.13/defconfig-2

for you to fetch changes up to 82cc56ccf127899cde1d74a0380c29814ceb1b71:

  ARM: davinci_all_defconfig: enable USB CDC NCM gadget (2017-06-16 13:38:42 +0530)

----------------------------------------------------------------
Enable mtdtests and USB NCM gadget in DaVinci kernel
(as modules).

----------------------------------------------------------------
Sekhar Nori (2):
      ARM: davinci_all_defconfig: enable mtdtests
      ARM: davinci_all_defconfig: enable USB CDC NCM gadget

 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)
