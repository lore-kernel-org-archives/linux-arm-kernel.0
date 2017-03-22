From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Mar 2017 11:26:18 -0600
Subject: [PATCH V2 4/5] dt-bindings: tegra: Update compatible strings for
 Tegra flowctrl
In-Reply-To: <1490202056-13040-5-git-send-email-jonathanh@nvidia.com>
References: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
 <1490202056-13040-5-git-send-email-jonathanh@nvidia.com>
Message-ID: <b85e7f4e-ba63-8374-b10d-3f9f04252a69@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 11:00 AM, Jon Hunter wrote:
> Update the compatible strings for Tegra Flow Control driver to match
> the device-tree source files for Tegra.

> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt

> +  - "nvidia,tegra124-flowctrl": for Tegra124 and Tegra132

I think that should be:

+  - "nvidia,tegra124-flowctrl": for Tegra124
+  - "nvidia,tegra132-flowctrl", "nvidia,tegra124-flowctrl": for \
Tegra132
