From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 4 Sep 2014 11:11:45 -0500
Subject: [GIT PULL 2/2] SOCFPGA driver updates for 3.18
In-Reply-To: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <1409847105-27241-2-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

Please consider pulling this patch for v3.18. Boris had given me permission to
take this patch together with it's DTS component. The DTS portion was in the
previous pull request.

Thanks,
Dinh

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga_driver_for_v3.18

for you to fetch changes up to 0730c4a52ef777a3098e00363e56858f14d6d323:

  edac: altera: Add Altera SDRAM EDAC support (2014-09-04 11:05:23 -0500)

----------------------------------------------------------------
SOCFPGA driver update for v3.18

----------------------------------------------------------------
Thor Thayer (1):
      edac: altera: Add Altera SDRAM EDAC support

 MAINTAINERS                |   5 +
 drivers/edac/Kconfig       |   9 +
 drivers/edac/Makefile      |   2 +
 drivers/edac/altera_edac.c | 410 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 426 insertions(+)
 create mode 100644 drivers/edac/altera_edac.c
