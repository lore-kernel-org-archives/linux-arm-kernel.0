From: monstr@monstr.eu (Michal Simek)
Date: Tue, 6 Dec 2016 13:46:01 +0100
Subject: [GIT PULL] ARM: Xilinx Zynq SOC changes for v4.10
Message-ID: <1ff060ae-b142-9e72-6fef-21b81a147614@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull this fix to your tree.

Thanks,
Michal


The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.10

for you to fetch changes up to 7a3cc2a7b2c723aa552028f4e66841cec183756d:

  ARM: zynq: Reserve correct amount of non-DMA RAM (2016-11-14 16:07:58
+0100)

----------------------------------------------------------------
arm: Xilinx Zynq patches for v4.10

- Fix dma issue

----------------------------------------------------------------
Kyle Roeschley (1):
      ARM: zynq: Reserve correct amount of non-DMA RAM

 arch/arm/mach-zynq/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)



-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161206/773ac815/attachment-0001.sig>
