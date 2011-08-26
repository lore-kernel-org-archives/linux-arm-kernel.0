From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Aug 2011 22:19:34 -0700
Subject: [PATCH 1/2] sdhci/tegra: Add Device Tree probing support
In-Reply-To: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
References: <1314123334-23133-1-git-send-email-swarren@nvidia.com>
Message-ID: <CAOesGMgS0LZdSA9LFvn+_bkdnKfT4d3n6mZCe=vpTGK1c1y+cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 11:15 AM, Stephen Warren <swarren@nvidia.com> wrote:
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

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
