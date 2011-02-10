From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 10 Feb 2011 08:45:21 -0800
Subject: [PATCH v4 10/15] ARM: tegra: iomap: Add missing devices, fix
	use of SZ_8, SZ_64
In-Reply-To: <1297320204-31882-11-git-send-email-ccross@android.com>
References: <1297320204-31882-1-git-send-email-ccross@android.com>
	<1297320204-31882-11-git-send-email-ccross@android.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F60414@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin Cross wrote at Wednesday, February 09, 2011 11:43 PM:
> 
> From: Gary King <gking@nvidia.com>
> 
> Adds gart, hdmi, avp, host1x, and pwm controllers to mach/iomap.h
> There is no SZ_8 or SZ_64, replace them with constants

Can't we add those SZ_* constants?

-- 
nvpublic
