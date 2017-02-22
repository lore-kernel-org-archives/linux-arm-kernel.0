From: elder@linaro.org (Alex Elder)
Date: Wed, 22 Feb 2017 08:36:21 -0600
Subject: [PATCH v2 1/2] dt-bindings: arm: hisilicon: add bindings for
 hi3798cv200 SoC and Poplar board
In-Reply-To: <1487752716-14824-2-git-send-email-xuejiancheng@hisilicon.com>
References: <1487752716-14824-1-git-send-email-xuejiancheng@hisilicon.com>
 <1487752716-14824-2-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <842d2c57-3ea4-7e43-57a7-ddf69f44eceb@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22/2017 02:38 AM, Jiancheng Xue wrote:
> Add bindings for HiSilicon hi3798cv200 SoC and Poplar Board.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>

I reviewed this before; the only change is it's separated
from the original patch.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index f1c1e21..1fd3dd7 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -4,6 +4,10 @@ Hi3660 SoC
>  Required root node properties:
>  	- compatible = "hisilicon,hi3660";
>  
> +Hi3798cv200 Poplar Board
> +Required root node properties:
> +	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
> +
>  Hi4511 Board
>  Required root node properties:
>  	- compatible = "hisilicon,hi3620-hi4511";
> 
