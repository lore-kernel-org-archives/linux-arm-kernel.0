From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 5 Jul 2011 23:55:39 -0600
Subject: [PATCH 0/3] tegra: Use engineering names in DT compatible
	properties
In-Reply-To: <1309897762-23564-1-git-send-email-swarren@nvidia.com>
References: <1309897762-23564-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110706055539.GG9978@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 02:29:19PM -0600, Stephen Warren wrote:
> Grant, these 3 patches are for the devicetree/test branch. I kept them
> separated in the hope they'll squash into existing patches already there.

Thanks, I'll pick them up and squash them in.

g.

> 
> Stephen Warren (3):
>   mmc/tegra: Use engineering names in DT compatible property
>   ARM: tegra: Use engineering names in DT compatible property
>   dt: docs: tegra: Use engineering names in DT compatible property
> 
>  Documentation/devicetree/usage-model |   12 ++--
>  arch/arm/boot/dts/tegra-harmony.dts  |    4 +-
>  arch/arm/boot/dts/tegra-seaboard.dts |    4 +-
>  arch/arm/boot/dts/tegra20.dtsi       |  162 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/tegra250.dtsi      |  162 ----------------------------------
>  arch/arm/mach-tegra/board-dt.c       |   32 ++++----
>  drivers/mmc/host/sdhci-pltfm.c       |    2 +-
>  7 files changed, 189 insertions(+), 189 deletions(-)
>  create mode 100644 arch/arm/boot/dts/tegra20.dtsi
>  delete mode 100644 arch/arm/boot/dts/tegra250.dtsi
> 
