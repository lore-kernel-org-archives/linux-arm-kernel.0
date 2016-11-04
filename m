From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Nov 2016 11:55:35 +0530
Subject: [GIT PULL 4/4] DaVinci defconfig updates for v4.10
In-Reply-To: <20161104062535.9593-1-nsekhar@ti.com>
References: <20161104062535.9593-1-nsekhar@ti.com>
Message-ID: <20161104062535.9593-4-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/defconfig

for you to fetch changes up to 6e9be8608771192851a3adf59f0ba9240e3f802c:

  ARM: davinci_all_defconfig: enable LED default-on trigger (2016-11-01 11:42:54 +0530)

----------------------------------------------------------------
Some updates to davinci_all_defconfig for MMC,
LCDC and GPIO/LEDs.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: davinci_all_defconfig: enable LCDC DRM driver

David Lechner (3):
      ARM: davinci_all_defconfig: enable gpio poweroff driver
      ARM: davinci_all_defconfig: build MMC into kernel
      ARM: davinci_all_defconfig: enable LED default-on trigger

 arch/arm/configs/davinci_all_defconfig | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)
