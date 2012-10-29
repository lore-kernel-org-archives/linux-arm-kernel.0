From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Oct 2012 12:21:28 -0600
Subject: [PATCH V2 1/4] ARM: tegra: dts: add slink controller dt entry
In-Reply-To: <1351531180-1652-2-git-send-email-ldewangan@nvidia.com>
References: <1351531180-1652-1-git-send-email-ldewangan@nvidia.com>
 <1351531180-1652-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <508EC928.7030900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2012 11:19 AM, Laxman Dewangan wrote:
> Add slink controller details in the dts file of
> Tegra20 and Tegra30.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	slink at 7000d400 {

I think the node names should be spi at ..., since the generic controller
type is SPI, even if NVIDIA happens to called the controllers SLINK and SBC.
