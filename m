From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 20 Jan 2012 09:40:45 -0800
Subject: [PATCH v4 07/15] ARM: tegra: convert to
 twd_local_timer_register() interface
In-Reply-To: <1327061042-14857-8-git-send-email-marc.zyngier@arm.com>
References: <1327061042-14857-1-git-send-email-marc.zyngier@arm.com>
 <1327061042-14857-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB39F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote at Friday, January 20, 2012 5:04 AM:
> Add support for the new smp_twd runtime registration interface
> to the tegra platforms, and remove the old compile-time support.
> Tested on Harmony.
> 
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

For Tegra,
Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
