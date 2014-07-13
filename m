From: Vincent.Yang@tw.fujitsu.com (Vincent Yang)
Date: Sun, 13 Jul 2014 13:21:06 +0800
Subject: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
Message-ID: <1405228870-5088-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
We are adding support for a new Fujitsu sdhci IP.
These patches are preparations and will be used by Fujitsu
SDHCI controller f_sdh30 driver.

These patches are against v3.16-rc4 mainline since nothing in
mmc-next at this moment.

These patches are tested on 3.16-rc4 integration tree.

We welcome any comment and advice about how to make any
improvements or better align them with upstream.

Thanks a lot!

Best regards,
Vincent Yang


Vincent Yang (4):
  mmc: sdhci: add quirk for voltage switch callback
  mmc: sdhci: add quirk for tuning work around
  mmc: sdhci: add quirk for single block transactions
  mmc: core: hold SD Clock before CMD11 during Signal

 drivers/mmc/core/core.c   |  4 ++--
 drivers/mmc/host/sdhci.c  | 15 ++++++++++++---
 drivers/mmc/host/sdhci.h  |  1 +
 include/linux/mmc/sdhci.h |  6 ++++++
 4 files changed, 21 insertions(+), 5 deletions(-)

-- 
1.9.0
