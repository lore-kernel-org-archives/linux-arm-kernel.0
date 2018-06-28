From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 28 Jun 2018 08:44:06 +0200
Subject: [RFC PATCH 2/5] dt-bindings: xilinx: Add missing zynq boards
In-Reply-To: <20180628054205.17737-3-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-3-luaraneda@gmail.com>
Message-ID: <eda7ca2a-e2de-8939-0784-89b619f6035e@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.6.2018 07:42, Luis Araneda wrote:
> The bindings were missing when adding the device-tree files
> Also, improve description of existing boards
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  .../devicetree/bindings/arm/xilinx.txt        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index b9043bc35..f1e911058 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -8,15 +8,33 @@ Required root node properties:
>  
>  Additional compatible strings:
>  
> -- Xilinx internal board cc108
> +- Xilinx CC108 board

No reason to remove internal word from here.

>    "xlnx,zynq-cc108"
>  
> -- Xilinx internal board zc770 with different FMC cards
> +- Avnet MicroZed board
> +  "avnet,zynq-microzed"
> +
> +- Adapteva Parallella board
> +  "adapteva,parallella"
> +
> +- Xilinx ZC702 board
> +  "xlnx,zynq-zc702"
> +
> +- Xilinx ZC706 board
> +  "xlnx,zynq-zc706"
> +
> +- Xilinx ZC770 board, with different FMC cards
>    "xlnx,zynq-zc770-xm010"
>    "xlnx,zynq-zc770-xm011"
>    "xlnx,zynq-zc770-xm012"
>    "xlnx,zynq-zc770-xm013"
>  
> +- Avnet ZedBoard board
> +  "avnet,zynq-zed"
> +
> +- Digilent Zybo board
> +  "digilent,zynq-zybo"
> +
>  - Digilent Zybo Z7 board
>    "digilent,zynq-zybo-z7"
>  
> 

Not a problem to add missing strings.

Thanks,
Michal
