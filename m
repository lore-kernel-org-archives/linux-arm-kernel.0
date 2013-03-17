From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Sun, 17 Mar 2013 13:16:46 -0500
Subject: [PATCH 0/4] Add SD support for PXA168 & gplugD
Message-ID: <1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for on-chip SD controller on PXA168

Tanmay Upadhyay (4):
  mmc: sdhci-pxa: Trivial fix in Kconfig
  ARM: pxa168: Add SDHCI support
  mmc: sdhci-pxa: Add SDHCI driver for PXA16x
  ARM: pxa168/gplugd: Add support for SD port 1

 arch/arm/mach-mmp/Kconfig               |    1 -
 arch/arm/mach-mmp/clock-pxa168.c        |   47 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/gplugd.c              |    6 ++++
 arch/arm/mach-mmp/include/mach/pxa168.h |   20 +++++++++++++
 arch/arm/mach-mmp/pxa168.c              |    4 +++
 drivers/mmc/host/Kconfig                |   11 ++++----
 drivers/mmc/host/sdhci-pxav2.c          |   30 +++++++++++++++++++-
 drivers/mmc/host/sdhci.c                |    3 ++
 drivers/mmc/host/sdhci.h                |    1 +
 include/linux/platform_data/pxa_sdhci.h |    2 ++
 10 files changed, 118 insertions(+), 7 deletions(-)

-- 
1.7.9.5

*************************************************************************************************************************************************************
eInfochips Business Disclaimer : This e-mail message and all attachments transmitted with it are intended solely for the use of the addressee and may contain legally privileged and confidential information. If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution, copying, or other use of this message or its attachments is strictly prohibited. If you have received this message in error, please notify the sender immediately by replying to this message and please delete it from your computer. Any views expressed in this message are those of the individual sender unless otherwise stated. Company has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
*************************************************************************************************************************************************************


---------------------------------------------------------------------------------------------
Notice: 
This message has been scanned by Trend Micro Mail Security scanner and is believed to be clean
---------------------------------------------------------------------------------------------
