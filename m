From: cjb@laptop.org (Chris Ball)
Date: Tue, 23 Aug 2011 14:41:05 -0400
Subject: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
In-Reply-To: <1314123334-23133-1-git-send-email-swarren@nvidia.com> (Stephen
	Warren's message of "Tue, 23 Aug 2011 12:15:33 -0600")
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
Message-ID: <m2ippo2cou.fsf@bob.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Aug 23 2011, Stephen Warren wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Add hooks to read gpio configuration out of the device tree node.
>
> [grant.likely: Rewrite of original patch from John Bonesio]
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> [swarren: Fixed tegra_sdhci_get_ro() to retrieve pdata correctly]
> [swarren: Reworked to avoid #ifdef CONFIG_OF]
> [swarren: Reworked binding based on fsl-imx-esdhc.txt]
> [swarren: Documented binding]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Theoretically, these two patches should be merged in order in one place,
> since the 2nd logically depends on the first. However, it's really just
> a documentation dependency, so I think it's fine to merge them into the
> MMC and DT trees separately and let them meet in linux-next.
>
>  .../devicetree/bindings/mmc/nvidia-sdhci.txt       |   25 ++++++++++
>  drivers/mmc/host/sdhci-tegra.c                     |   51 +++++++++++++++----
>  2 files changed, 65 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/nvidia-sdhci.txt

Okay, I've pushed this patch [1/2] to mmc-next for 3.2.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
