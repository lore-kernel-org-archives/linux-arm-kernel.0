From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 13:46:13 -0700
Subject: [PATCH 04/10] ARM: tegra: Add Tegra124 eDP support
In-Reply-To: <1387469182-14398-5-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-5-git-send-email-treding@nvidia.com>
Message-ID: <52B35B15.4090008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 09:06 AM, Thierry Reding wrote:

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi

> +		sor at 54540000 {
> +			compatible = "nvidia,tegra124-sor";

I don't see a binding document for that compatible value anywhere in
next-20131219, nor in your drm/for-next branch. Still, the DT
content/schema is essentially identical to many others that already
exist, so I won't block applying the series because of that. Please do
write a binding document though!

> +		dpaux at 545c0000 {
> +			compatible = "nvidia,tegra124-dpaux";

Same comment.
