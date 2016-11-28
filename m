From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 17:12:19 +0530
Subject: [GIT PULL 4/4] DaVinci defconfig updates for v4.10 (part 3)
In-Reply-To: <20161128114219.22325-1-nsekhar@ti.com>
References: <20161128114219.22325-1-nsekhar@ti.com>
Message-ID: <20161128114219.22325-5-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a652baa06413a4beacc09425883e518c5f1ed100:

  ARM: davinci_all_defconfig: add missing options for systemd (2016-11-15 15:44:52 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/defconfig-3

for you to fetch changes up to 213971e7571e27f47b4e926904a9adf794925c51:

  ARM: davinci_all_defconfig: Enable OHCI as module (2016-11-22 20:50:46 +0530)

----------------------------------------------------------------
A patch enabling USB OHCI support in davinci
defconfig.

----------------------------------------------------------------
Axel Haslam (1):
      ARM: davinci_all_defconfig: Enable OHCI as module

 arch/arm/configs/davinci_all_defconfig | 1 +
 1 file changed, 1 insertion(+)
