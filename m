From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 13 Mar 2014 11:27:11 -0700
Subject: [PATCH] ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM
In-Reply-To: <1394660600-3771-1-git-send-email-nm@ti.com> (Nishanth Menon's
 message of "Wed, 12 Mar 2014 16:43:20 -0500")
References: <1394660600-3771-1-git-send-email-nm@ti.com>
Message-ID: <7hy50ekl8g.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Just like IS_PM34XX_ERRATUM, IS_PM44XX_ERRATUM is valid only if
> CONFIG_PM is enabled, else, disabling CONFIG_PM results in build
> failure complaining about the following:
> arch/arm/mach-omap2/built-in.o: In function `omap4_boot_secondary':
> :(.text+0x8a70): undefined reference to `pm44xx_errata'
>
> Fixes: c962184 (ARM: OMAP4: PM: add errata support)
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
