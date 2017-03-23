From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 23 Mar 2017 16:21:06 +0530
Subject: [GIT PULL 3/3] DaVinci defconfig updates for v4.12
In-Reply-To: <20170323105106.20144-1-nsekhar@ti.com>
References: <20170323105106.20144-1-nsekhar@ti.com>
Message-ID: <20170323105106.20144-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/defconfig

for you to fetch changes up to 507c318d5ee7d05da6d94041dd42abe0cfdd62cf:

  ARM: davinci_all_defconfig: Enable TI ADS7950 (2017-03-07 15:48:21 +0530)

----------------------------------------------------------------
DaVinci defconfig updates for enabling
Video capture and display on DA850 and
an ADC driver thats used by Lego EV3.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      ARM: davinci_all_defconfig: enable VPIF display modules
      ARM: davinci_all_defconfig: enable IRQ support for pca953x

David Lechner (1):
      ARM: davinci_all_defconfig: Enable TI ADS7950

 arch/arm/configs/davinci_all_defconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
