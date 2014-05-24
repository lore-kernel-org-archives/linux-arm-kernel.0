From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 24 May 2014 15:13:33 +0530
Subject: [GIT PULL 02/02] DaVinci board changes for v3.16
In-Reply-To: <1400924613-24451-1-git-send-email-nsekhar@ti.com>
References: <1400924613-24451-1-git-send-email-nsekhar@ti.com>
Message-ID: <1400924613-24451-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.16/board

for you to fetch changes up to ea56785629494394b9e567c0a43690d6c972e137:

  ARM: davinci: remove checks for CONFIG_USB_MUSB_PERIPHERAL (2014-05-22 16:29:08 +0530)

----------------------------------------------------------------
This patch clean-up an unused #define
from code.

----------------------------------------------------------------
Paul Bolle (1):
      ARM: davinci: remove checks for CONFIG_USB_MUSB_PERIPHERAL

 arch/arm/configs/davinci_all_defconfig      |    1 -
 arch/arm/mach-davinci/board-dm355-evm.c     |    4 ----
 arch/arm/mach-davinci/board-dm355-leopard.c |    4 ----
 3 files changed, 9 deletions(-)
