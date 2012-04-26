From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 14:01:36 -0600
Subject: [PATCHv3 4/4] ARM: dt: tegra: Add device tree support for AHB
In-Reply-To: <1335352072-4001-4-git-send-email-hdoyu@nvidia.com>
References: <1335352072-4001-1-git-send-email-hdoyu@nvidia.com>
 <1335352072-4001-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <4F99A9A0.1030304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2012 05:07 AM, Hiroshi DOYU wrote:
> Add AHB entry for tegra20/30.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	ahb: ahb at 6000c004 {
> +		compatible = "nvidia,tegra30-ahb", "nvidia,tegra20-ahb";

This should only be tegra20-ahb in the Tegra20 file.
