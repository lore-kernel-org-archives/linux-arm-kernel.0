From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 29 May 2017 11:18:25 +0200
Subject: [PATCH] ARM: at91: select CONFIG_ARM_CPU_SUSPEND
In-Reply-To: <20170524153921.1682756-1-arnd@arndb.de>
References: <20170524153921.1682756-1-arnd@arndb.de>
Message-ID: <20170529091825.6coopaazjfvuu242@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/2017 at 17:39:03 +0200, Arnd Bergmann wrote:
> The reference to cpu_resume requires the corresponding
> generic code to be enabled when CONFIG_PM is set:
> 
> arch/arm/mach-at91/pm.o: In function `sama5d2_pm_init':
> pm.c:(.init.text+0x5e8): undefined reference to `cpu_resume'
> 
> Fixes: 24a0f5c539f9 ("ARM: at91: pm: Add sama5d2 backup mode")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-at91/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
