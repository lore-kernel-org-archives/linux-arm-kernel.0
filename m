From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 13 Oct 2017 19:32:40 +0530
Subject: [GIT PULL 2/2] DaVinci defconfig updates for v4.15
In-Reply-To: <20171013140240.18599-1-nsekhar@ti.com>
References: <20171013140240.18599-1-nsekhar@ti.com>
Message-ID: <20171013140240.18599-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.15/defconfig

for you to fetch changes up to 5627453efabf8eef84ce1dce6767d1268570a6c5:

  ARM: davinci_all_defconfig: enable CMA options (2017-09-21 20:08:29 +0530)

----------------------------------------------------------------
Enable CMA and MTD command line partitioning support.

----------------------------------------------------------------
Adam Ford (1):
      ARM: davinci_all_defconfig: enable MTD_CMDLINE_PARTS

Suman Anna (1):
      ARM: davinci_all_defconfig: enable CMA options

 arch/arm/configs/davinci_all_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
