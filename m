From: monstr@monstr.eu (Michal Simek)
Date: Thu, 20 Feb 2014 16:26:37 +0100
Subject: [GIT PULL] Xilinx Zynq dt changes for v3.15
Message-ID: <53061EAD.9000000@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull this patch to your arm-soc tree.

Thanks,
Michal

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git-dev/group/ssw/linux-xlnx.git tags/zynq-dt-for-3.15

for you to fetch changes up to 3795e91d2abb25164dda5687ca680a7ab940c447:

  arm: dt: zynq: Add fclk-enable property to clkc node (2014-02-03 17:00:24 +0100)

----------------------------------------------------------------
arm: Xilinx Zynq dt patches for v3.15

- Define fclk-enable property

----------------------------------------------------------------
Soren Brinkmann (1):
      arm: dt: zynq: Add fclk-enable property to clkc node

 arch/arm/boot/dts/zynq-7000.dtsi | 1 +
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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/aaff48c5/attachment.sig>
