From: monstr@monstr.eu (Michal Simek)
Date: Thu, 03 Apr 2014 17:00:29 +0200
Subject: [RFC PATCH v2] edac: synopsys: Added EDAC support for zynq ddr
 ecc controller
In-Reply-To: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
References: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
Message-ID: <533D778D.8040002@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav,

On 03/17/2014 06:23 AM, Punnaiah Choudary Kalluri wrote:
> Added EDAC support for reporting the ecc errors of synopsys ddr controller.
> The ddr ecc controller corrects single bit errors and detects double bit
> errors
> 
> Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> ---
> Changes for v2:
> - Updated the commit header and message
> - Renamed the filenames to synopsys_edac
> - Corrected the compatilble string, commnets
> - Renamed the macros,fucntions and data structures
> ---
>  .../devicetree/bindings/edac/synopsys_edac.txt     |   18 +
>  drivers/edac/Kconfig                               |    7 +
>  drivers/edac/Makefile                              |    1 +
>  drivers/edac/synopsys_edac.c                       |  614 ++++++++++++++++++++
>  4 files changed, 640 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/synopsys_edac.txt
>  create mode 100644 drivers/edac/synopsys_edac.c

Do you have any comment about this driver?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/23fc1abf/attachment-0001.sig>
