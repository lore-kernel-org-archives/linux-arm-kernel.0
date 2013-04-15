From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 15 Apr 2013 22:53:19 +0530
Subject: [GIT PULL 3/3] ARM: davinci: board updates for v3.10 (part 2)
In-Reply-To: <1366046599-6590-1-git-send-email-nsekhar@ti.com>
References: <1366046599-6590-1-git-send-email-nsekhar@ti.com>
Message-ID: <1366046599-6590-3-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following board updates for v3.10. This
depends on SoC updates in previous request.

Thanks,
Sekhar

The following changes since commit 1511a86e71baebc7b27da5f52cbaf3272f13d556:

  ARM: davinci: ensure global variables are declared (2013-04-15 15:13:13 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v3.10/board-2

for you to fetch changes up to 38406c06e00a1cef839ac3efb886df153bb8f448:

  ARM: davinci: da850 evm: fix const qualifier placement (2013-04-15 15:17:06 +0530)

----------------------------------------------------------------
v3.10 board updates for DaVinci

This set of patches enables remoteproc support
on DA850 EVM and fixes some sparse warnings for
the same board.

----------------------------------------------------------------
Robert Tivy (1):
      ARM: davinci: da850 board: add remoteproc support

Sekhar Nori (1):
      ARM: davinci: da850 evm: fix const qualifier placement

 arch/arm/mach-davinci/board-da850-evm.c     |   10 ++++++++--
 arch/arm/mach-davinci/board-omapl138-hawk.c |    6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)
