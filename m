From: scott.branden@broadcom.com (Scott Branden)
Date: Tue,  1 Nov 2016 09:37:55 -0700
Subject: [PATCH v2 0/2] mmc: sdhci-iproc: Add byte register access support
Message-ID: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add brcm,sdhci-iproc compat string and code for support of newer versions of
sdhci-iproc controller that allow byte-wise register accesses.

Changes from v1:
- added details to bindings documentation to clarify usage of brcm,sdhci-iproc
compatibility string

Scott Branden (2):
  mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings
    document
  mmc: sdhci-iproc: support standard byte register accesses

 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  9 ++++++
 drivers/mmc/host/sdhci-iproc.c                     | 35 ++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.5.0
