From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 13 Jul 2011 12:31:23 -0700
Subject: [PATCH 2/2] ARM: Tegra: Seaboard: Re-order sdhci device
	registration
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF049E834796@HQMAIL01.nvidia.com>
References: <1306876448-28147-1-git-send-email-swarren@nvidia.com>
	<1306876448-28147-3-git-send-email-swarren@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF049E834796@HQMAIL01.nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E8347B9@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Stephen Warren wrote at Wednesday, July 13, 2011 12:56 PM:
> Stephen Warren wrote at Tuesday, May 31, 2011 3:14 PM:
> > Ensure the built-in eMMC is always named mmcblk0.
> 
> Colin, could you please consider this for 3.1?

Never mind, I see this has already been applied; I must have missed the
email saying so, and the local rebase of my branch didn't show it as
already applied since the tegra next branch only got pushed out last
night and isn't in linux-next yet.

Sorry for the noise.

-- 
nvpublic
