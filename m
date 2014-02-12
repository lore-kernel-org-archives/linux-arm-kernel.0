From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 16:55:34 +0100
Subject: [PATCH 0/14] Xilinx axi ethernet patches
Message-ID: <cover.1392220536.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have exctracted patches which I have in our
xilinx git tree which are missing in the mainline.

The first two patches fix compilation error and
warnings. Then 5 feature patches
and the rest is OF cleanup and with kernel-doc
and checkpatch problems.

Thanks,
Michal


Michal Simek (4):
  net: axienet: Fix compilation error
  net: axienet: Fix compilation warnings
  net: axienet: Fix comments blocks
  net: axienet: Fix kernel-doc warnings

Peter Crosthwaite (2):
  net: axienet: Handle 0 packet receive gracefully
  net: axienet: Service completion interrupts ASAP

Srikanth Thokala (8):
  net: axienet: Support for RGMII
  net: axienet: Handle jumbo frames for lesser frame sizes
  net: axienet: Support phy-less mode of operation
  net: axienet: Removed checkpatch errors/warnings
  net: axienet: Use pdev instead of op
  net: axienet: Use devm_* calls
  net: axienet: Use of_property_* calls
  net: axienet: Removed _of_ prefix in probe and remove functions

 drivers/net/ethernet/xilinx/xilinx_axienet.h      | 108 ++++----
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 307 ++++++++++++----------
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c |  30 ++-
 3 files changed, 241 insertions(+), 204 deletions(-)

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/c0b11373/attachment.sig>
