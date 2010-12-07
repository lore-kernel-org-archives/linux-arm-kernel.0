From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 7 Dec 2010 14:38:19 +0200
Subject: [PATCH 3/4] omap1: Add omap1_defconfig
In-Reply-To: <20101204213657.32208.50997.stgit@baageli.muru.com>
References: <20101204213358.32208.4195.stgit@baageli.muru.com>
	<20101204213657.32208.50997.stgit@baageli.muru.com>
Message-ID: <AANLkTi=siEk_ZLY0k94ktv_sUAF5AO3PTkT-4ynDqLX7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 4, 2010 at 11:36 PM, Tony Lindgren <tony@atomide.com> wrote:
> The omap1_defconfig this should be eventually usable for booting
> all omap1 machines. Generated based on:
>
> $ grep ARCH_OMAP1=y arch/arm/configs/* | cut -d: -f1 | xargs cat | \
> ? ? sort | uniq >> arch/arm/configs/omap1_defconfig
>
> Then change few things manually, like use Nokia 770 CONFIG_CMDLINE
> as it does not allow setting it in the bootloader.
>
> After make oldconfig, ran reduce_defconfig python script on it
> as posted by Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

AFAIK you should use 'make savedefconfig'.

-- 
Felipe Contreras
