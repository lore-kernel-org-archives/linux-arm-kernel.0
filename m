From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 13 Feb 2014 08:10:41 +0100
Subject: [PATCH v2 0/2] Xilinx axi ethernet bug fixes
Message-ID: <cover.1392275432.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Based on our discussion I am sending 2 bug fixes for axi ethernet
driver against your net tree.

Thanks,
Michal

Changes in v2:
- Separate bug fixes from features and cleanups

Michal Simek (2):
  net: axienet: Fix compilation error
  net: axienet: Fix compilation warnings

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/f8f12a4c/attachment-0001.sig>
