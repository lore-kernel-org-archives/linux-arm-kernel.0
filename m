From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 24 Sep 2018 12:51:02 -0700
Subject: [GIT_PULL] SOC: driver updates for v4.20
Message-ID: <1537818662-6307-1-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_4.20

for you to fetch changes up to 7bcfe20d0d8b647879629798fa57e39905d6cded:

  soc: ti: fix spelling mistake "instace" -> "instance" (2018-09-24 12:43:21 -0700)

----------------------------------------------------------------
soc: driver soc update for v4.20

  - Enable host-id as an optional dt property
  - Fix minor typo in knav driver

----------------------------------------------------------------
Colin King (1):
      soc: ti: fix spelling mistake "instace" -> "instance"

Nishanth Menon (2):
      Documentation: dt: keystone: ti-sci: Add optional host-id parameter
      firmware: ti_sci: Provide host-id as an optional dt parameter

 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
 drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
 drivers/soc/ti/knav_dma.c                          |  4 ++--
 drivers/soc/ti/knav_qmss.h                         |  6 +++---
 4 files changed, 29 insertions(+), 9 deletions(-)
