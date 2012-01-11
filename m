From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 12:48:26 -0800
Subject: [PATCH V1] ARM: tegra: Pause DMA when reading transfer count
In-Reply-To: <1326175511-28642-1-git-send-email-ldewangan@nvidia.com>
References: <1326175511-28642-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A77E@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laxman Dewangan wrote at Monday, January 09, 2012 11:05 PM:
> In order to read an accurate channel transfer count
> from the APB DMA engine, the DMA controller must be
> paused first.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

(Audio playback on Harmony booted using device tree works fine in my
brief testing)

-- 
nvpublic
