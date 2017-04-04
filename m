From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 4 Apr 2017 14:55:47 +0530
Subject: [GIT PULL 4/4] DaVinci defconfig updates for v4.12 (part 2)
In-Reply-To: <20170404092547.32480-1-nsekhar@ti.com>
References: <20170404092547.32480-1-nsekhar@ti.com>
Message-ID: <20170404092547.32480-4-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 507c318d5ee7d05da6d94041dd42abe0cfdd62cf:

  ARM: davinci_all_defconfig: Enable TI ADS7950 (2017-03-07 15:48:21 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.12/defconfig-2

for you to fetch changes up to 2e5d77ef042a22fa1aa393a294999d28f7136d27:

  ARM: davinci_all_defconfig: convert to use libata PATA (2017-03-30 16:16:17 +0530)

----------------------------------------------------------------
Shift to the newly introduced PalmChip
PATA driver for DaVinci.

----------------------------------------------------------------
Sekhar Nori (1):
      ARM: davinci_all_defconfig: convert to use libata PATA

 arch/arm/configs/davinci_all_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
