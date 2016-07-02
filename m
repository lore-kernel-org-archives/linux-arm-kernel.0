From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat,  2 Jul 2016 19:23:12 +0000
Subject: [PATCH 0/2] mmc: sdhci-iproc: Use defines instead of magic numbers
Message-ID: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this small patch series should make the sdhci-iproc platform data easier
to read. Since i don't have the adequate hardware it's only compile tested.

Stefan

Stefan Wahren (2):
  mmc: sdhci: add define for suspend/resume capability
  mmc: sdhci-iproc: Use defines instead of magic numbers

 drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
 drivers/mmc/host/sdhci.h       |    1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
1.7.9.5
