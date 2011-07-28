From: tony.lin@freescale.com (Tony Lin)
Date: Thu, 28 Jul 2011 15:15:59 +0800
Subject: [PATCH v2 0/1] ARM: mxc: fix card interrupt losing issue on freescale
	eSDHC
Message-ID: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the patch provides a workaround for eSDHC to avoid missing the card interrupt

changes since V1
* fix some comments typo
* V2 patch is based on Chris Ball's tree, mmc-next branch

Tony Lin (1):
  ARM: mxc: fix card interrupt losing issue on freescale eSDHC

 drivers/mmc/host/sdhci-esdhc-imx.c |   44 +++++++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 10 deletions(-)
