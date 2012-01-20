From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 20 Jan 2012 08:43:58 -0800
Subject: [PATCH] ARM: move CP15 definitions to separate header file
In-Reply-To: <E1RoBJw-0005UP-By@rmk-PC.arm.linux.org.uk>
References: <E1RoBJw-0005UP-By@rmk-PC.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB37A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Friday, January 20, 2012 3:04 AM:
> Avoid namespace conflicts with drivers over the CP15 definitions by
> moving CP15 related prototypes and definitions to a private header
> file.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For Tegra,

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
