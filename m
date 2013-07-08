From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Jul 2013 09:51:08 -0600
Subject: [PATCH V2] ARM: tegra: enable gpio-keys on dalmore
In-Reply-To: <1373102069-5641-1-git-send-email-ldewangan@nvidia.com>
References: <1373102069-5641-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <51DADFEC.1050901@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2013 03:14 AM, Laxman Dewangan wrote:
> Dalmore have the keys mounted on board which are connected
> to different pins of Tegra.
> 
> Add the keys entry in DTS file to enable key functionality.
> This will enable KEY_POWER, KEY_HOME, KEY_VOLUMEUP and
> KEY_VOLUMEDOWN.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

> @@ -976,4 +1005,5 @@
>  			 <&tegra_car TEGRA114_CLK_EXTERN1>;
>  		clock-names = "pll_a", "pll_a_out0", "mclk";
>  	};
> +
>  };

What's that? I'll try to remember to fix this up when applying, but
proof-reading would help.
