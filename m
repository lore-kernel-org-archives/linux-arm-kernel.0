From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Apr 2013 22:44:03 +0200
Subject: [PATCH v5 01/14] ARM: SAMSUNG: Move samsung-time to
 drivers/clocksource
In-Reply-To: <1365794250-14436-2-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
 <1365794250-14436-2-git-send-email-t.figa@samsung.com>
Message-ID: <201304122244.03964.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 April 2013, Tomasz Figa wrote:
> ---
>  arch/arm/plat-samsung/Kconfig        |   8 -
>  arch/arm/plat-samsung/Makefile       |   1 -
>  arch/arm/plat-samsung/samsung-time.c | 394 -----------------------------------
>  drivers/clocksource/Kconfig          |   7 +
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/samsung_pwm.c    | 394 +++++++++++++++++++++++++++++++++++

In general, please send patches generated with 'git format-patch -M'. You can
set that as a default using 'git config diff.renames true'.

	Arnd
