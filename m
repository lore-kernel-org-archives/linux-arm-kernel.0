From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Jan 2016 16:14:38 +0100
Subject: [PATCH v4 11/13] mmc: sdhci-tegra: use sdhci_pltfm_init for
 private allocation
In-Reply-To: <1453803353-6266-12-git-send-email-jszhang@marvell.com>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
 <1453803353-6266-12-git-send-email-jszhang@marvell.com>
Message-ID: <20160127151438.GA28536@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 06:15:51PM +0800, Jisheng Zhang wrote:
> Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
> allows users of sdhci_pltfm to allocate private space in calls to
> sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-tegra
> to this allocation.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

Tested-by: Thierry Reding <treding@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/e192d26f/attachment-0001.sig>
