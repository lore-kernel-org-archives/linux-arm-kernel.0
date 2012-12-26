From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Wed, 26 Dec 2012 09:40:20 +0530
Subject: [PATCH 2/3] ARM: OMAP AM33xx: hwmod data: resolve sparse warnings
In-Reply-To: <20121224012458.13698.43620.stgit@dusk.lan>
References: <20121224012304.13698.43551.stgit@dusk.lan>
 <20121224012458.13698.43620.stgit@dusk.lan>
Message-ID: <50DA78AC.9090601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/24/2012 6:55 AM, Paul Walmsley wrote:
> Commit 70384a6af0914d5dcec034643941e29d3e3e69f7 ("ARM: OMAP3+:
> hwmod: Add AM33XX HWMOD data for davinci_mdio module") adds two
> new sparse warnings:
>
> arch/arm/mach-omap2/omap_hwmod_33xx_data.c:2518:30: warning: symbol 'am33xx_mdio_addr_space' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_33xx_data.c:2526:26: warning: symbol 'am33xx_cpgmac0__mdio' was not declared. Should it be static?
>
> Fix by marking the two new records as static.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Mugunthan V N <mugunthanvnm@ti.com>
> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
>
Looks good to me.
Acked-by : Mugunthan V N <mugunthanvnm@ti.com>
