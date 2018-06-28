From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Thu, 28 Jun 2018 18:41:45 +0530
Subject: [PATCH v3 net-next 0/5] Fixes coding style in xilinx_emaclite.c
Message-ID: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes checkpatch and kernel-doc warnings in
xilinx emaclite driver. No functional change.

Changes from v2:
-In 2/5 patch refactor if-else to make failure path return early.
-In 2/5 patch coalesce the format onto a single line and add the
missing space after the comma.

Radhey Shyam Pandey (5):
  net: emaclite: Use __func__ instead of hardcoded name
  net: emaclite: Simplify if-else statements
  net: emaclite: update kernel-doc comments
  net: emaclite: Fix block comments style
  net: emaclite: Remove unnecessary spaces

 drivers/net/ethernet/xilinx/xilinx_emaclite.c |  112 ++++++++++++++-----------
 1 files changed, 64 insertions(+), 48 deletions(-)
