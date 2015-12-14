From: monstr@monstr.eu (Michal Simek)
Date: Mon, 14 Dec 2015 13:28:13 +0100
Subject: [GIT PULL] ARM32: Xilinx Zynq SoC changes for v4.5
Message-ID: <566EB5DD.8070308@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull this one patch to your tree.

Thanks,
Michal

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-4.5

for you to fetch changes up to 8f039f9a692ab7014e2818a4e372231e134553f9:

  ARM: zynq: Select ARCH_HAS_RESET_CONTROLLER (2015-12-14 09:33:08 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq patches for v4.5

- Select reset controller by default for Zynq

----------------------------------------------------------------
Moritz Fischer (1):
      ARM: zynq: Select ARCH_HAS_RESET_CONTROLLER

 arch/arm/mach-zynq/Kconfig | 1 +
 1 file changed, 1 insertion(+)
	

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
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151214/df8249a7/attachment.sig>
