From: monstr@monstr.eu (Michal Simek)
Date: Fri, 20 Dec 2013 13:35:34 +0100
Subject: [GIT PULL v2] Xilinx Zynq clk changes for v3.14
Message-ID: <52B43996.8000300@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike

as we discussed I have rebased this branch on your clk-next branch
and I have removed one dt patch which will go through arm-soc tree.

Please pull this patch to your tree.

Thanks,
Michal

The following changes since commit 24c039f6acacd63e739b39a030197d5a2945e0d2:

  clk: ux500: Remove extra semicolon (2013-12-19 17:47:33 -0800)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-clk-for-3.14-v2

for you to fetch changes up to ba52f8a986089e263ea28e231b6a405769ae1235:

  clk/zynq/clkc: Add 'fclk-enable' feature (2013-12-20 13:23:55 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq clk patches for v3.14

- Add support for fclk-enable feature

----------------------------------------------------------------
Soren Brinkmann (1):
      clk/zynq/clkc: Add 'fclk-enable' feature

 Documentation/devicetree/bindings/clock/zynq-7000.txt |  4 ++++
 drivers/clk/zynq/clkc.c                               | 18 +++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/ee7eb365/attachment.sig>
