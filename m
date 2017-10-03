From: anup.patel@broadcom.com (Anup Patel)
Date: Tue,  3 Oct 2017 10:51:47 +0530
Subject: [PATCH 0/5] Few more FlexRM driver improvements
Message-ID: <1507008112-27117-1-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset does few more improvements to Broadcom FlexRM mailbox
driver.

The patches are based on Linux-4.14-rc3 and can also be found at
flexrm-imp2-v1 branch of:
https://github.com/Broadcom/arm64-linux.git

Anup Patel (4):
  mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush sequence
  mailbox: bcm-flexrm-mailbox: Print ring number in errors and warnings
  mailbox: bcm-flexrm-mailbox: Use common GPL comment header
  mailbox: Build Broadcom FlexRM driver as loadable module for iProc
    SOCs

Scott Branden (1):
  mailbox: bcm-flexrm-mailbox: add depends on ARCH_BCM_IPROC

 drivers/mailbox/Kconfig              |  3 +-
 drivers/mailbox/bcm-flexrm-mailbox.c | 66 ++++++++++++++++++++++++++----------
 2 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.7.4
