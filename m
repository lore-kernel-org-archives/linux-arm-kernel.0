From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 2 Aug 2017 14:49:01 +0300
Subject: [PATCH v3 10/11] ARM64: dts: rockchip: Add gmac2phy node support
 for rk3328
In-Reply-To: <1501655097-21054-1-git-send-email-david.wu@rock-chips.com>
References: <1501654546-17292-1-git-send-email-david.wu@rock-chips.com>
 <1501655097-21054-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <6b97127d-8ac9-99a8-2d03-2dfc0dc9e86f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 08/02/2017 09:24 AM, David Wu wrote:

> The gmac2phy controller of rk3328 is connected to internal phy
> directly inside, add the node for the internal phy support.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> index 0be96ce..51c8c66 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
[...]
> @@ -424,6 +426,29 @@
>   		status = "disabled";
>   	};
>   
> +	gmac2phy: eth at ff550000 {

    The standardized name is ethernet at ...

[...]

MBR, Sergei
