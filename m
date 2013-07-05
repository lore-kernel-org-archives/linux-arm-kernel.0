From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 05 Jul 2013 11:38:11 -0600
Subject: [PATCH 1/2] ARM: dt: t30 cardhu: add dt entry for lm90
In-Reply-To: <1372928979-26938-2-git-send-email-wni@nvidia.com>
References: <1372928979-26938-1-git-send-email-wni@nvidia.com>
 <1372928979-26938-2-git-send-email-wni@nvidia.com>
Message-ID: <51D70483.70203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2013 03:09 AM, Wei Ni wrote:
> Enable thermal sensor lm90 for t30 cardhu.

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi

> +		nct1008: nct1008 {
> +			compatible = "lm90,nct1008";

"lm90" isn't a valid vendor prefix. I believe the value you want is
"onnn,nct1008". Same comment for patch 2/2.
