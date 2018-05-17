From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 17 May 2018 18:38:45 +0530
Subject: [GIT PULL 3/3] DaVinci defconfig updates for v4.18
In-Reply-To: <20180517130845.863-1-nsekhar@ti.com>
References: <20180517130845.863-1-nsekhar@ti.com>
Message-ID: <20180517130845.863-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.18/defconfig

for you to fetch changes up to e081c754ad4b8665364fcfb07b8bec5289f23dd8:

  ARM: davinci_all_defconfig: enable support for remoteproc drivers (2018-04-23 20:24:23 +0530)

----------------------------------------------------------------
Enable DA8XX remoteproc driver support in davinci_all_defconfig

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: davinci_all_defconfig: enable support for remoteproc drivers

 arch/arm/configs/davinci_all_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
