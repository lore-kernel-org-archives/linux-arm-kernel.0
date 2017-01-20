From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 20 Jan 2017 14:56:26 +0000
Subject: [V2 1/2] document: dt: add binding for Hi3660 SoC
In-Reply-To: <1484034915-48879-1-git-send-email-puck.chen@hisilicon.com>
References: <1484034915-48879-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <5882251A.8030100@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen Feng,

On 2017/1/10 7:55, Chen Feng wrote:
> Add binding for hisilicon Hi3660 SoC and HiKey960 Board.
> 
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied both to the hisilicon SoC tree
with minimal changes about the format.
Thanks!

Best Regards,
Wei

>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index 7df79a7..6de2398 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -8,6 +8,10 @@ Hi6220 SoC
>  Required root node properties:
>  	- compatible = "hisilicon,hi6220";
>  
> +Hi3660 SoC
> +Required root node properties:
> +	- compatible = "hisilicon,hi3660";
> +
>  HiKey Board
>  Required root node properties:
>  	- compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
> 
