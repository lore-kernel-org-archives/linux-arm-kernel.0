From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 May 2011 21:13:31 -0700
Subject: [RFC 1/3] ARM: Tegra: Device Tree Support: Update how sdhci
	devices	are initialized
In-Reply-To: <20110511232637.10362.84551.stgit@riker>
References: <20110511231905.10362.12844.stgit@riker>
	<20110511232637.10362.84551.stgit@riker>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AA2C2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Bonesio wrote at Wednesday, May 11, 2011 5:27 PM:
> This patch changes how sdhci devices are initialized so that a later patch can
> easily add support for i2c devies.
>...
> diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
>...
> +#include <mach/sdhci.h>
>...
> +#include "gpio-names.h"

I don't think either of those headers are needed any more.

Otherwise, looks good.

-- 
nvpublic
