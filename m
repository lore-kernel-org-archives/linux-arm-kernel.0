From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 2 Feb 2017 19:03:48 +0530
Subject: [GIT PULL 4/4] DaVinci defconfig updates (part 2)
In-Reply-To: <20170202133348.32713-1-nsekhar@ti.com>
References: <20170202133348.32713-1-nsekhar@ti.com>
Message-ID: <20170202133348.32713-4-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 685db57ace04411387b33e607d6abde9763819e7:

  ARM: davinci_all_defconfig: enable iio (2017-01-20 17:21:03 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.11/defconfig-2

for you to fetch changes up to 484290350c8d6ec119d255304ff32d7e255ed208:

  ARM: davinci_all_defconfig: enable SATA modules (2017-01-31 16:25:14 +0530)

----------------------------------------------------------------
Enable SATA support found on DA850 SoC.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: davinci_all_defconfig: enable SATA modules

 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)
