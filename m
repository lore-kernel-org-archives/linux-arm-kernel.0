From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 12 Oct 2016 11:35:50 -0700
Subject: [PATCH 0/2] mmc: sdhci-iproc: Add byte register access support
Message-ID: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add brcm,sdhci-iproc compat string and code for support of newer versions of
sdhci-iproc controller that allow byte-wise register accesses.

Scott Branden (2):
  mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings
    document
  mmc: sdhci-iproc: support standard byte register accesses

 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  1 +
 drivers/mmc/host/sdhci-iproc.c                     | 35 ++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.5.0
