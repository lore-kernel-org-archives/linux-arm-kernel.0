From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 3 Feb 2012 11:59:29 -0800
Subject: [PATCH 0/3] arm: tegra: dts: USB Updates for Tegra legacy mode
 / OTG
In-Reply-To: <1328288172-8059-1-git-send-email-sjg@chromium.org>
References: <1328288172-8059-1-git-send-email-sjg@chromium.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E5D2FF5@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Glass wrote at riday, February 03, 2012 9:56 AM:
> This little series brings in some bindings that seem useful for U-Boot.
> 
> I am working mostly in U-Boot, but since there is no shared .dts repo
> I was asked to commit these changes to the kernel. I do not propose to
> update the Linux USB drivers to match.

I think the series looks reasonable, so:

Acked-by: Stephen Warren <swarren@nvidia.com<>

(I note that the kernel's USB driver for USB1 doesn't attempt to clear
legacy mode; I wonder how we're getting away with that. Perhaps it's
only been tested with a bootloader that's already cleared legacy mode)

-- 
nvpublic
