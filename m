From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Apr 2014 13:17:01 -0600
Subject: [RFC 2/5] ARM: tegra: Add new PCIe regulator properties
In-Reply-To: <1396622969-17837-3-git-send-email-treding@nvidia.com>
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
 <1396622969-17837-3-git-send-email-treding@nvidia.com>
Message-ID: <53444B2D.8050209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 08:49 AM, Thierry Reding wrote:
> These new properties more accurately reflect the real connections of the
> boards and therefore make it easier to match them up with schematics.

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi

>  	pcie-controller at 00003000 {
>  		status = "okay";
> +
> +		/* AVDD_PEXA and VDD_PEXA are grounded on Cardhu. */

Perhaps add the word "inputs" before "are"?
