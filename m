From: monstr@monstr.eu (Michal Simek)
Date: Mon, 02 Dec 2013 12:20:02 +0100
Subject: [PATCH 1/2] net: emaclite: Remove unnecessary code that
 enables/disables interrupts on PONG buffers
In-Reply-To: <f9b49a0c-0627-432d-b6c9-faeaa7c412b8@CH1EHSMHS011.ehs.local>
References: <f9b49a0c-0627-432d-b6c9-faeaa7c412b8@CH1EHSMHS011.ehs.local>
Message-ID: <529C6CE2.60909@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28/2013 08:29 AM, Srikanth Thokala wrote:
> There are no specific interrupts for the PONG buffer on both
> transmit and receive side, same interrupt is valid for both
> buffers. So, this patch removes this code.
> 
> Signed-off-by: Srikanth Thokala <sthokal@xilinx.com>
> ---
>  drivers/net/ethernet/xilinx/xilinx_emaclite.c | 38 ---------------------------
>  1 file changed, 38 deletions(-)

Reviewed-by: Michal Simek <monstr@monstr.eu>

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
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/0e3ce709/attachment.sig>
