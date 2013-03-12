From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 13:28:32 -0600
Subject: [PATCH V2 3/9] ARM: dt: tegra: add bindings of power management
 configurations for PMC
In-Reply-To: <1363060962-9172-1-git-send-email-josephl@nvidia.com>
References: <1363060962-9172-1-git-send-email-josephl@nvidia.com>
Message-ID: <513F81E0.5030808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 10:02 PM, Joseph Lo wrote:
> The PMC mostly controls the entry and exit of the system from different
> sleep modes. Different platform or system may have different configurations.
> The power management configurations of PMC is represented as some properties.
> The system needs to define the properties when the system supports deep sleep
> mode (i.e. suspend).

> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt

> +  Valid valuse are 0, 1 and 2:

s/valuse/values/
