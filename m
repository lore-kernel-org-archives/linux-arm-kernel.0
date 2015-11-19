From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 19 Nov 2015 21:49:31 +0100
Subject: [PATCH] arm64: dts: berlin: PSCI-1.0 support
In-Reply-To: <1447673869-842-1-git-send-email-jszhang@marvell.com>
References: <1447673869-842-1-git-send-email-jszhang@marvell.com>
Message-ID: <564E35DB.9080902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.11.2015 12:37, Jisheng Zhang wrote:
> The firmware can support PSCI-1.0 in fact. This change also enables
> suspend to ram on Marvell berlin arm64 SoC.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Appled to berlin64/dt.

Thanks!

> ---
>  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> index 8eddf10..a87f1a2 100644
> --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> @@ -55,7 +55,7 @@
>  	};
>  
>  	psci {
> -		compatible = "arm,psci-0.2";
> +		compatible = "arm,psci-1.0", "arm,psci-0.2";
>  		method = "smc";
>  	};
>  
> 
