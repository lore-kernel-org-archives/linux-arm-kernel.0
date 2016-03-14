From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 14 Mar 2016 14:36:47 +0000
Subject: [PATCH] ARM64: tegra: Remove unused #power-domain-cells property
In-Reply-To: <1457101603-8426-1-git-send-email-jonathanh@nvidia.com>
References: <1457101603-8426-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <56E6CC7F.4090901@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/03/16 14:26, Jon Hunter wrote:
> Remove the "#power-domain-cells" property which was incorrectly
> included by commit e53095857166 ("arm64: tegra: Add Tegra210
> support").
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> 
> ARM-SOC maintainers, could we get this into to the v4.5-rc cycle?
> This only appeared since Tegra210 was added for v4.5 and so it
> would be good to correct this before the final v4.5.

Did not look like this made v4.5. So Thierry I am not sure if you just
want to pick this up now?

Cheers
Jon
