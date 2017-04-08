From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 8 Apr 2017 14:46:58 +0800
Subject: [PATCH v3 1/2] dt-bindings: arm: hisilicon: add bindings for
 hi3798cv200 SoC and Poplar board
In-Reply-To: <1490769009-12552-2-git-send-email-xuejiancheng@hisilicon.com>
References: <1490769009-12552-1-git-send-email-xuejiancheng@hisilicon.com>
 <1490769009-12552-2-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <58E88762.6060000@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiancheng,

On 2017/3/29 14:30, Jiancheng Xue wrote:
> Add bindings for HiSilicon hi3798cv200 SoC and Poplar Board.
>
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Reviewed-by: Alex Elder <elder@linaro.org>
> Acked-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
Thanks!
Applied both to the hisilicon arm64 dt tree but added hi3798cv200 soc
binding to avoid the patch checking warning.

Best Regards,
Wei
> ---
>   Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> index f1c1e21..1fd3dd7 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
> @@ -4,6 +4,10 @@ Hi3660 SoC
>   Required root node properties:
>   	- compatible = "hisilicon,hi3660";
>   
> +Hi3798cv200 Poplar Board
> +Required root node properties:
> +	- compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
> +
>   Hi4511 Board
>   Required root node properties:
>   	- compatible = "hisilicon,hi3620-hi4511";
