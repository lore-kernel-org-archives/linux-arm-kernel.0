From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 16 Nov 2011 09:13:42 -0800
Subject: [PATCH 0/23] mach/vmalloc.h removal, and ioremap optimization
In-Reply-To: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740D748BE@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote at Tuesday, November 15, 2011 10:48 PM:
> This patch series removes all instances of mach/vmalloc.h in order to
> have a more unified memory map across all ARM architectures. ...

For Tegra, the series:

Tested-by: Stephen Warren <swarren@nvidia.com>

(On Seaboard/Springbank, booted DT, booted non-DT and tested audio, both
with root filesystem on SD card)

-- 
nvpublic
