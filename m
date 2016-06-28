From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 10:27:56 +0800
Subject: [PATCH 0/6] kill off cpu_is_mx*()
In-Reply-To: <20160624105001.3166287-1-arnd@arndb.de>
References: <20160624105001.3166287-1-arnd@arndb.de>
Message-ID: <20160628022756.GD21328@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 12:49:55PM +0200, Arnd Bergmann wrote:
> I noticed that i.MX still uses the traditional cpu_is_* functions to
> tell the difference between various SoC families, but every single
> user of those can be replaced with a simpler way, so we can just
> remove it all.
> 
> Please review and apply for 4.8 if it looks good to you.
> 
> Arnd Bergmann (6):
>   ARM: imx: remove cpu_is_mx1 check
>   ARM: imx: deconstruct mxc_rnga initialization
>   ARM: imx: deconstruct mx3_idle
>   ARM: imx: rework mx27_pm_init() call
>   ARM: imx: remove last call to cpu_is_mx5*
>   ARM: imx: remove cpu_is_mx*()

Thanks for cleaning this up.  Applied all.

Shawn
