From: davem@davemloft.net (David Miller)
Date: Thu, 09 Feb 2017 17:06:16 -0500 (EST)
Subject: [PATCH] [net-next] ARM: orion: remove unused
 wnr854t_switch_plat_data
In-Reply-To: <20170208212431.2924390-1-arnd@arndb.de>
References: <20170208212431.2924390-1-arnd@arndb.de>
Message-ID: <20170209.170616.2056403989254038271.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  8 Feb 2017 22:24:19 +0100

> The other instances of this structure got removed along with the MDIO
> device change, but this one was left behind and needs to be removed
> as well:
> 
> arch/arm/mach-orion5x/wnr854t-setup.c:109:44: error: 'wnr854t_switch_plat_data' defined but not used [-Werror=unused-variable]
>  static struct dsa_platform_data __initdata wnr854t_switch_plat_data = {
> 
> Fixes: 575e93f7b5e6 ("ARM: orion: Register DSA switch as a MDIO device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
