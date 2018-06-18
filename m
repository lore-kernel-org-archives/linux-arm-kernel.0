From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 18 Jun 2018 17:20:05 +0530
Subject: [PATCH 0/5]  Fixes coding style in xilinx_emaclite.c
Message-ID: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes checkpatch and kernel-doc warnings in
xilinx emaclite driver. No functional change.

Radhey Shyam Pandey (5):
  net: emaclite: Use __func__ instead of hardcoded name
  net: emaclite: Balance braces in else statement
  net: emaclite: update kernel-doc comments
  net: emaclite: Fix block comments style
  net: emaclite: Remove unnecessary spaces

 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 101 +++++++++++++++-----------
 1 file changed, 58 insertions(+), 43 deletions(-)

-- 
2.7.4
