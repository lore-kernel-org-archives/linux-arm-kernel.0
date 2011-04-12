From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 12 Apr 2011 12:00:44 -0700
Subject: [PATCH] ARM: Tegra: Seaboard board updates for audio
In-Reply-To: <1302629547-2368-1-git-send-email-swarren@nvidia.com>
References: <1302629547-2368-1-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0493EB3EA2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Tuesday, April 12, 2011 11:32 AM:
> * Initialize clock tree for audio
> * Add GPIO base definitions
> * Add audio GPIO definitions
> * Define platform data for WM8903 and ASoC machine driver
> * Add special case for Kaen to handle HP_MUTE GPIO
> * Register platform devices for audio
> * Update pinmux to cater for new GPIOs used for audio
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

I forgot to point out that this patch depends on the series "[PATCH 0/3]
Rename Tegra ASoC driver" having been merged first.

-- 
nvpublic
