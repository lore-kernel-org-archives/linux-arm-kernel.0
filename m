From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Jun 2012 14:17:32 -0600
Subject: [PATCH v2 08/10] ARM: tegra: harmony: Initialize regulators from
 DT
In-Reply-To: <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de>
 <1339427118-32263-9-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4FE3815C.8030505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 09:05 AM, Thierry Reding wrote:
> Device tree support for the TPS6586x PMU used on Harmony has recently
> been added. This commit adds the required device tree nodes to probe the
> PMU from the device tree.

> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts

> +		tps6586x at 34 {
> +			compatible = "ti,tps6586x";
> +			reg = <0x34>;
> +			interrupts = <0 88 0x4>;

I believe that should be interrupt 86 not 88.
