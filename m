From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 10:38:59 +0000
Subject: [PATCH 01/17] arm/tegra: board-dt: audio: Enable clocks, fix
 AUXDATA
In-Reply-To: <1322011285-4002-2-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-2-git-send-email-swarren@nvidia.com>
Message-ID: <20111123103858.GK4332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:09PM -0700, Stephen Warren wrote:

>  	OF_DEV_AUXDATA("nvidia,tegra20-i2c", TEGRA_DVC_BASE, "tegra-i2c.3", NULL),
>  	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.0", NULL),
> -	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.1", NULL),
> +	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S2_BASE, "tegra-i2s.1", NULL),

This looks like a straight bug fix which is independant of the below
change?
