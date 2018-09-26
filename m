From: monstr@monstr.eu (Michal Simek)
Date: Wed, 26 Sep 2018 09:32:31 +0200
Subject: [GIT PULL] ARM: Xilinx Zynq SoC patches for v4.20
Message-ID: <834bfbfb-9f20-c900-a449-1904de2e24cf@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please apply this one Rob's patch to your tree.

Thanks,
Michal


The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://github.com/Xilinx/linux-xlnx.git tags/zynq-soc-for-v4.20

for you to fetch changes up to 20487a8ddf207dde042a4463e3f82ab17c17cf13:

  ARM: zynq: Convert to using %pOFn instead of device_node.name
(2018-09-05 15:27:16 +0200)

----------------------------------------------------------------
ARM: Xilinx Zynq SoC patches for v4.20

- Convert to using %pOFn instead of device_node.name in slcr driver

----------------------------------------------------------------
Rob Herring (1):
      ARM: zynq: Convert to using %pOFn instead of device_node.name

 arch/arm/mach-zynq/slcr.c | 2 +-
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180926/12d1878d/attachment-0001.sig>
