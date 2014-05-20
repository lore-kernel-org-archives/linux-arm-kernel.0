From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 May 2014 11:25:54 -0600
Subject: [PATCH v2 1/3] mmc: tegra: disable UHS modes
In-Reply-To: <1397689719-28882-2-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397689719-28882-1-git-send-email-abrestic@chromium.org>
 <1397689719-28882-2-git-send-email-abrestic@chromium.org>
Message-ID: <537B9022.20709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2014 05:08 PM, Andrew Bresticker wrote:
> Program TEGRA_SDHCI_VENDOR_MISC_CTRL so that UHS modes aren't advertised
> in SDHCI_CAPABILITIES_1.  While the Tegra SDHCI controller does support
> these modes, they require Tegra-specific tuning and calibration routines
> which the driver does not support yet.

What's the status of patches 1 and 2 in this series? I assumed they'd be
applied to the MMC tree. I've had them applied to my local development
tree for a while now, so in case this helps:

Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>

(I thought I wrote that before, but I can't find it, so I must have
forgotten to)
