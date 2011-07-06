From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 5 Jul 2011 23:50:18 -0600
Subject: [PATCH] ARM: tegra: Harmony: Use engineering names in DT
	compatible property
In-Reply-To: <1309897408-23085-1-git-send-email-swarren@nvidia.com>
References: <1309897408-23085-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110706055018.GF9978@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 02:23:28PM -0600, Stephen Warren wrote:
> Engineering names are more stable than marketing names. Hence, use them
> for Device Tree compatible properties instead.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Grant, this is against devicetree/arm, and only makes sense there; I'll
> send a separate patch for the equivalent change in devicetree/test, since
> the file is radically different there.

devicetree/arm actually does track devicetree/test, just a subset of
the patches in it (although it isn't obvious since I use stgit to make
devicetree/arm a stable branch that never rebases.

I'll make sure both devicetree/arm and devicetree/test are fixed up.

g.

> 
>  arch/arm/boot/dts/tegra-harmony.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra-harmony.dts
> index 81032e7..4ad8ade 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -3,5 +3,5 @@
>  
>  / {
>  	model = "NVIDIA Tegra2 Harmony evaluation board";
> -	compatible = "nvidia,harmony", "nvidia,tegra250";
> +	compatible = "nvidia,harmony", "nvidia,tegra20";
>  };
> -- 
> 1.7.0.4
> 
