From: monstr@monstr.eu (Michal Simek)
Date: Wed, 30 Jul 2014 13:27:51 +0200
Subject: [PATCH] ARM: zynq: DT: Clarify Xilinx Zynq platform
In-Reply-To: <7153c8eded88751e7637f08f2bfe9cb6a65036e7.1406275971.git.michal.simek@xilinx.com>
References: <7153c8eded88751e7637f08f2bfe9cb6a65036e7.1406275971.git.michal.simek@xilinx.com>
Message-ID: <53D8D6B7.5030309@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2014 10:15 AM, Michal Simek wrote:
> ep107 was emulation platform and compatible string
> have been changed long time ago.
> 
> "ARM: zynq: dts: split up device tree"
> (sha1: e06f1a9ed7ebff170ba05d2606d079fb36c6a52d)
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/xilinx.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index 6f1ed830b4f7..1f7995357888 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -1,7 +1,7 @@
> -Xilinx Zynq EP107 Emulation Platform board
> +Xilinx Zynq Platforms Device Tree Bindings
> 
> -This board is an emulation platform for the Zynq product which is
> -based on an ARM Cortex A9 processor.
> +Boards with Zynq-7000 SOC based on an ARM Cortex A9 processor
> +shall have the following properties.
> 
>  Required root node properties:
> -    - compatible = "xlnx,zynq-ep107";
> +    - compatible = "xlnx,zynq-7000";
> --
> 1.8.2.3
> 

Applied to zynq/dt.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140730/08c84e53/attachment.sig>
