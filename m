From: dinguyen@altera.com (dinguyen at altera.com)
Date: Fri, 25 Apr 2014 17:57:50 -0500
Subject: [GIT PULL] SOCFPGA driver updates for 3.16
In-Reply-To: <1398466670-8341-1-git-send-email-dinguyen@altera.com>
References: <1398466670-8341-1-git-send-email-dinguyen@altera.com>
Message-ID: <1398466670-8341-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

Please consider pulling in this patch for 3.16. It adds a reset driver for
the SOCFPGA platform.

Thanks,
Dinh

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-driver-update-for-3.16

for you to fetch changes up to a39a493932dfc534cb761d6f95861a281e57c1e7:

  reset: add driver for socfpga (2014-04-25 17:40:08 -0500)

----------------------------------------------------------------
drivers: Add reset driver for SOCFPGA

Add a reset driver for the SOCFPGA platform.

----------------------------------------------------------------
Steffen Trumtrar (1):
      reset: add driver for socfpga

 drivers/reset/Makefile        |    1 +
 drivers/reset/reset-socfpga.c |  146 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 147 insertions(+)
 create mode 100644 drivers/reset/reset-socfpga.c
