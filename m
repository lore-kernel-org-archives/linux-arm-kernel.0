From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Feb 2017 14:03:02 -0800
Subject: [PATCH] [net-next] ARM: orion: remove unused
 wnr854t_switch_plat_data
In-Reply-To: <20170208212431.2924390-1-arnd@arndb.de>
References: <20170208212431.2924390-1-arnd@arndb.de>
Message-ID: <764ddf86-4f5b-e883-0cb4-9a83c1455593@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2017 01:24 PM, Arnd Bergmann wrote:
> The other instances of this structure got removed along with the MDIO
> device change, but this one was left behind and needs to be removed
> as well:
> 
> arch/arm/mach-orion5x/wnr854t-setup.c:109:44: error: 'wnr854t_switch_plat_data' defined but not used [-Werror=unused-variable]
>  static struct dsa_platform_data __initdata wnr854t_switch_plat_data = {
> 
> Fixes: 575e93f7b5e6 ("ARM: orion: Register DSA switch as a MDIO device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Arnd!
-- 
Florian
