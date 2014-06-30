From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jun 2014 14:40:43 -0600
Subject: [PATCH 2/6] of: Add bindings for nvidia,tegra124-soctherm
In-Reply-To: <1403856699-2140-3-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-3-git-send-email-mperttunen@nvidia.com>
Message-ID: <53B1CB4B.7050706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2014 02:11 AM, Mikko Perttunen wrote:
> This adds binding documentation and headers for the Tegra124
> SOCTHERM device tree node.

> diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt

> +Required properties :
...
> +- #thermal-sensor-cells : For thermctl sensors. Should be 1.

I'd prefer a tiny bit more information here: A link to whatever other
document defines the meaning of #thermal-sensor-cells, and a link to the
header that defines the meaning of the data in the cell. Perhaps:

#thermal-sensor-cells : Should be 1. See ./thermal.txt for a description
of this property. See <dt-bindings/thermal/tegra124-soctherm.h> for a
list of valid values.

> diff --git a/include/dt-bindings/thermal/tegra124-soctherm.h b/include/dt-bindings/thermal/tegra124-soctherm.h
> +#endif
> +
> +

There are a couple of blank lines at the end of that file.
