From: monstr@monstr.eu (Michal Simek)
Date: Tue, 21 Jan 2014 10:00:51 +0100
Subject: Question: xilinx_zynq_defconfig
In-Reply-To: <20140121173442.328B.AA925319@jp.panasonic.com>
References: <20140121173442.328B.AA925319@jp.panasonic.com>
Message-ID: <52DE3743.9000109@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

zynq is enabled in multi_v7 defconfig that's why I don't have
a need to add defconfig just for zynq. Even one defconfig per soc
is permitted by maintainers.

In xilinx repo we keep more defconfigs.

Thanks,
Michal

On 01/21/2014 09:34 AM, Masahiro Yamada wrote:
> Hello Michal,
> 
> I have a Zynq ZC706 board.
> I have a simple question about Zynq support.
> 
> There exist device tree sources for Zynq in the mainline of Kernel,
> whereas xilinx_zynq_defconfig is missing.
> (I know it is maintained in a Xilinx repository.)
> 
> Why have the defconfig files not been merged yet?
> 
> 
> Best Regards
> Masahiro Yamada
> 


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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140121/8ff1f469/attachment-0001.sig>
