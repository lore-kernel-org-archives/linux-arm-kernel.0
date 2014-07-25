From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jul 2014 10:01:33 +0200
Subject: [PATCH v2 01/11] Documentation: devicetree: Adapteva vendor prefix
In-Reply-To: <1406242820-20140-2-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-2-git-send-email-afaerber@suse.de>
Message-ID: <53D20EDD.9040206@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 01:00 AM, Andreas F?rber wrote:
> Cc: Andreas Olofsson <andreas@adapteva.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 46a311e..a8708c7 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -6,6 +6,7 @@ using them to avoid name-space collisions.
>  abilis	Abilis Systems
>  active-semi	Active-Semi International Inc
>  ad	Avionic Design GmbH
> +adapteva	Adapteva, Inc.
>  adi	Analog Devices, Inc.
>  aeroflexgaisler	Aeroflex Gaisler AB
>  ak	Asahi Kasei Corp.
> 

Applied zynq/dt branch.
https://github.com/Xilinx/linux-xlnx/commits/zynq/dt

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/05ae300b/attachment.sig>
