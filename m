From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 5 Dec 2016 16:33:16 +0530
Subject: [GIT PULL 2/2] DaVinci defconfig updates for v4.10 (part 4)
In-Reply-To: <20161205110316.18514-1-nsekhar@ti.com>
References: <20161205110316.18514-1-nsekhar@ti.com>
Message-ID: <20161205110316.18514-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 213971e7571e27f47b4e926904a9adf794925c51:

  ARM: davinci_all_defconfig: Enable OHCI as module (2016-11-22 20:50:46 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/defconfig-4

for you to fetch changes up to 47d03e48efa572109229aec9436948d92f44b689:

  ARM: davinci_all_defconfig: Enable da8xx usb otg (2016-12-01 19:52:12 +0530)

----------------------------------------------------------------
Enable support for MUSB based USB OTG on DA850.

----------------------------------------------------------------
Alexandre Bailon (1):
      ARM: davinci_all_defconfig: Enable da8xx usb otg

 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)
