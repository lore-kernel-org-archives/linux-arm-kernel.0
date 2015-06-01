From: monstr@monstr.eu (Michal Simek)
Date: Mon, 01 Jun 2015 09:12:55 +0200
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <20150601102511.316f0262@canb.auug.org.au>
References: <20150601102511.316f0262@canb.auug.org.au>
Message-ID: <556C05F7.70302@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/01/2015 02:25 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> arch/arm/boot/dts/zynq-7000.dtsi between commit 9eeb5161397a ("ARM:
> zynq: DT: Use the zynq binding with macb") from Linus' tree and commit
> 4481b18b7cf0 ("ARM: zynq: DT: Use the zynq binding with macb") from the
> arm-soc tree.
> 
> I fixed it up (it looks like that latter is a newer version of the
> former, so I used it) and can carry the fix as necessary (no action
> is required).
> 

David applied v1 of the patch. I have applied v2 (pulled via arm-soc)
which also keep backward compatible string. There should be two
compatible strings.

Thanks,
Michal

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
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/e2dc8a5c/attachment.sig>
