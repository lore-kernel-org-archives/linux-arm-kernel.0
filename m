From: monstr@monstr.eu (Michal Simek)
Date: Fri, 25 Jul 2014 10:01:50 +0200
Subject: [PATCH v2 02/11] Documentation: devicetree: Adapteva boards
In-Reply-To: <1406242820-20140-3-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-3-git-send-email-afaerber@suse.de>
Message-ID: <53D20EEE.5040601@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 01:00 AM, Andreas F?rber wrote:
> We're about to add a device tree for the Parallella board.
> 
> Cc: Andreas Olofsson <andreas@adapteva.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New
>  
>  Documentation/devicetree/bindings/arm/adapteva.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/adapteva.txt b/Documentation/devicetree/bindings/arm/adapteva.txt
> new file mode 100644
> index 0000000..1d8af9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/adapteva.txt
> @@ -0,0 +1,7 @@
> +Adapteva Platforms Device Tree Bindings
> +---------------------------------------
> +
> +Parallella board
> +
> +Required root node properties:
> +    - compatible = "adapteva,parallella";
> 


Applied to zynq/dt branch.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/e97b3652/attachment.sig>
