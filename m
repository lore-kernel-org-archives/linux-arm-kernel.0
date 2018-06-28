From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Jun 2018 08:41:57 +0200
Subject: [RFC PATCH 5/5] arm: dts: zynq: remove "zynq" prefix from
 compatible property
In-Reply-To: <20180628054205.17737-6-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-6-luaraneda@gmail.com>
Message-ID: <042f6632-f4f6-d278-9859-b8998468c3bf@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.6.2018 07:42, Luis Araneda wrote:
> The value "zynq" isn't officially part of the model on any board.
> Additionally, the value is redundant as it's included in a
> subsequent value of the property.
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  .../devicetree/bindings/arm/xilinx.txt        | 22 +++++++++----------
>  arch/arm/boot/dts/zynq-cc108.dts              |  2 +-
>  arch/arm/boot/dts/zynq-microzed.dts           |  2 +-
>  arch/arm/boot/dts/zynq-zc702.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc706.dts              |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm010.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm011.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm012.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zc770-xm013.dts        |  2 +-
>  arch/arm/boot/dts/zynq-zedboard.dts           |  2 +-
>  arch/arm/boot/dts/zynq-zybo-z7.dts            |  2 +-
>  arch/arm/boot/dts/zynq-zybo.dts               |  2 +-
>  12 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index d10adc4d0..0785acce4 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -9,34 +9,34 @@ Required root node properties:
>  Additional compatible strings:
>  
>  - Xilinx CC108 board
> -  "xlnx,zynq-cc108"
> +  "xlnx,cc108"
>  
>  - Avnet MicroZed board
> -  "avnet,zynq-microzed"
> +  "avnet,microzed"
>  
>  - Adapteva Parallella board
>    "adapteva,parallella"
>  
>  - Xilinx ZC702 board
> -  "xlnx,zynq-zc702"
> +  "xlnx,zc702"
>  
>  - Xilinx ZC706 board
> -  "xlnx,zynq-zc706"
> +  "xlnx,zc706"
>  
>  - Xilinx ZC770 board, with different FMC cards
> -  "xlnx,zynq-zc770-xm010"
> -  "xlnx,zynq-zc770-xm011"
> -  "xlnx,zynq-zc770-xm012"
> -  "xlnx,zynq-zc770-xm013"
> +  "xlnx,zc770-xm010"
> +  "xlnx,zc770-xm011"
> +  "xlnx,zc770-xm012"
> +  "xlnx,zc770-xm013"
>  
>  - Avnet ZedBoard board
> -  "avnet,zynq-zedboard"
> +  "avnet,zedboard"
>  
>  - Digilent Zybo board
> -  "digilent,zynq-zybo"
> +  "digilent,zybo"
>  
>  - Digilent Zybo Z7 board
> -  "digilent,zynq-zybo-z7"
> +  "digilent,zybo-z7"
>  
>  ---------------------------------------------------------------
>  
> diff --git a/arch/arm/boot/dts/zynq-cc108.dts b/arch/arm/boot/dts/zynq-cc108.dts
> index 8b9ab9bba..ccff20099 100644
> --- a/arch/arm/boot/dts/zynq-cc108.dts
> +++ b/arch/arm/boot/dts/zynq-cc108.dts
> @@ -13,7 +13,7 @@
>  
>  / {
>  	model = "Xilinx CC108 board";
> -	compatible = "xlnx,zynq-cc108", "xlnx,zynq-7000";
> +	compatible = "xlnx,cc108", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
> index 3cc957428..ef55adb02 100644
> --- a/arch/arm/boot/dts/zynq-microzed.dts
> +++ b/arch/arm/boot/dts/zynq-microzed.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Avnet MicroZed board";
> -	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
> +	compatible = "avnet,microzed", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 3f84b94db..bd633a9bc 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Xilinx ZC702 board";
> -	compatible = "xlnx,zynq-zc702", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc702", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
> index a15908cac..f4805f01b 100644
> --- a/arch/arm/boot/dts/zynq-zc706.dts
> +++ b/arch/arm/boot/dts/zynq-zc706.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Xilinx ZC706 board";
> -	compatible = "xlnx,zynq-zc706", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc706", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm010.dts b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> index 0e1bfdd34..21f457656 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm010.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm010.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM010 board";
> -	compatible = "xlnx,zynq-zc770-xm010", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm010", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm011.dts b/arch/arm/boot/dts/zynq-zc770-xm011.dts
> index b7f65862c..e4a0b2629 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm011.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm011.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM011 board";
> -	compatible = "xlnx,zynq-zc770-xm011", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm011", "xlnx,zynq-7000";
>  
>  	aliases {
>  		i2c0 = &i2c1;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm012.dts b/arch/arm/boot/dts/zynq-zc770-xm012.dts
> index d2359b789..d2ee09590 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm012.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm012.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM012 board";
> -	compatible = "xlnx,zynq-zc770-xm012", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm012", "xlnx,zynq-7000";
>  
>  	aliases {
>  		i2c0 = &i2c0;
> diff --git a/arch/arm/boot/dts/zynq-zc770-xm013.dts b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> index 651913f1a..9d6090ee4 100644
> --- a/arch/arm/boot/dts/zynq-zc770-xm013.dts
> +++ b/arch/arm/boot/dts/zynq-zc770-xm013.dts
> @@ -9,7 +9,7 @@
>  
>  / {
>  	model = "Xilinx ZC770 XM013 board";
> -	compatible = "xlnx,zynq-zc770-xm013", "xlnx,zynq-7000";
> +	compatible = "xlnx,zc770-xm013", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem1;
> diff --git a/arch/arm/boot/dts/zynq-zedboard.dts b/arch/arm/boot/dts/zynq-zedboard.dts
> index 540581c56..8a7894552 100644
> --- a/arch/arm/boot/dts/zynq-zedboard.dts
> +++ b/arch/arm/boot/dts/zynq-zedboard.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Avnet ZedBoard board";
> -	compatible = "avnet,zynq-zedboard", "xlnx,zynq-7000";
> +	compatible = "avnet,zedboard", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
> index be40be9b7..bcb633860 100644
> --- a/arch/arm/boot/dts/zynq-zybo-z7.dts
> +++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
> @@ -4,7 +4,7 @@
>  
>  / {
>  	model = "Digilent Zybo Z7 board";
> -	compatible = "digilent,zynq-zybo-z7", "xlnx,zynq-7000";
> +	compatible = "digilent,zybo-z7", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
> index 0439e9f1e..776d3d77d 100644
> --- a/arch/arm/boot/dts/zynq-zybo.dts
> +++ b/arch/arm/boot/dts/zynq-zybo.dts
> @@ -8,7 +8,7 @@
>  
>  / {
>  	model = "Digilent Zybo board";
> -	compatible = "digilent,zynq-zybo", "xlnx,zynq-7000";
> +	compatible = "digilent,zybo", "xlnx,zynq-7000";
>  
>  	aliases {
>  		ethernet0 = &gem0;
> 

zynq name here is correct which is saying that hardblock is going to be
described. Without it it is suggesting that hardblock is not used and it
is for example on zybo with microblaze.

Thanks,
Michal
