From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Mar 2013 14:48:46 -0600
Subject: [PATCH 3/4] ARM: tegra: dalmore: add dt node for TPS65090's
 regulators
In-Reply-To: <1363787070-14801-4-git-send-email-ldewangan@nvidia.com>
References: <1363787070-14801-1-git-send-email-ldewangan@nvidia.com>
 <1363787070-14801-4-git-send-email-ldewangan@nvidia.com>
Message-ID: <514A20AE.9040604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2013 07:44 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra114 platform, Dalmore, uses the TPS65090 as
> secondary PMICs which mainly act as voltage switch controlled
> by I2C communication.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

> @@ -747,4 +823,18 @@
>  		bus-width = <8>;
>  		status = "okay";
>  	};
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;

You need a blank line between the nodes there.

There a a number of typos and capitalization issues in the various
commit descriptions.
