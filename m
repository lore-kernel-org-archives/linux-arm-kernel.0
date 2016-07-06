From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 6 Jul 2016 15:23:53 +0300
Subject: [PATCH 2/3] arm64: dts: rockchip: add GMAC dt nodes for rk3399 SoC
In-Reply-To: <1467802291-6487-3-git-send-email-roger.chen@rock-chips.com>
References: <1467802291-6487-1-git-send-email-roger.chen@rock-chips.com>
 <1467802291-6487-3-git-send-email-roger.chen@rock-chips.com>
Message-ID: <f1e3270b-4908-2d81-9784-21c1cb77e2d9@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/6/2016 1:51 PM, Roger Chen wrote:

> This patch adds ethernet GMAC dt notes for Rockchip RK3399 SoC.
>
> Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 79 ++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index d7f8e06..cb0b17d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -189,6 +189,25 @@
>  		};
>  	};
>
> +	gmac: eth at fe300000 {

    The node should be named "ethernet at fe300000" to comply with the ePAPR 
standard.

[...]

MBR, Sergei
