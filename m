From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 13 Oct 2011 08:37:27 -0700
Subject: [PATCH] [RESEND]  ARM: tegra: devices.c should include devices.h
In-Reply-To: <1318467801-12184-1-git-send-email-olof@lixom.net>
References: <1318467801-12184-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A04F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Wednesday, October 12, 2011 7:03 PM:
> Resolves lots of sparse warnings:
> 
> arch/arm/mach-tegra/devices.c:102:24: warning: symbol 'tegra_i2c_device1' was not declared. Should it
> be static?
> arch/arm/mach-tegra/devices.c:112:24: warning: symbol 'tegra_i2c_device2' was not declared. Should it
> be static?
> arch/arm/mach-tegra/devices.c:122:24: warning: symbol 'tegra_i2c_device3' was not declared. Should it
> be static?
> arch/arm/mach-tegra/devices.c:132:24: warning: symbol 'tegra_i2c_device4' was not declared. Should it
> be static?
> [...]
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
