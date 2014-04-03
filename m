From: monstr@monstr.eu (Michal Simek)
Date: Thu, 03 Apr 2014 17:02:30 +0200
Subject: [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
In-Reply-To: <a1a9e47a-069c-4285-9899-d5a58cf532c2@CO9EHSMHS003.ehs.local>
References: <1393770760-32550-1-git-send-email-punnaia@xilinx.com>
 <a1a9e47a-069c-4285-9899-d5a58cf532c2@CO9EHSMHS003.ehs.local>
Message-ID: <533D7806.8070002@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 03/02/2014 03:32 PM, Punnaiah Choudary Kalluri wrote:
> Add support for ARM Pl310 L2 cache controller parity error
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---
>  .../devicetree/bindings/edac/pl310_edac_l2.txt     |   19 ++
>  drivers/edac/Kconfig                               |    7 +
>  drivers/edac/Makefile                              |    1 +
>  drivers/edac/pl310_edac_l2.c                       |  236 ++++++++++++++++++++
>  4 files changed, 263 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/pl310_edac_l2.txt
>  create mode 100644 drivers/edac/pl310_edac_l2.c

Any comment about this driver?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/98f56fcb/attachment.sig>
