From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Aug 2014 14:22:19 -0600
Subject: [PATCH v2 1/5] of: Add descriptions of thermtrip properties to
 Tegra PMC bindings
In-Reply-To: <1407933685-12404-2-git-send-email-mperttunen@nvidia.com>
References: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
 <1407933685-12404-2-git-send-email-mperttunen@nvidia.com>
Message-ID: <53F5037B.3030401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 06:41 AM, Mikko Perttunen wrote:
> Hardware-triggered thermal reset requires configuring the I2C
> reset procedure. This configuration is read from the device tree,
> so document the relevant properties in the binding documentation.

> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt

> +Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
> +- nvidia,pinmux-id : Pinmux used by the hardware when issuing poweroff command.
> +                     Defaults to 0.

We should either enumerate the legal values and what they mean, or 
include a reference to the TRM section which explains the legal values.
