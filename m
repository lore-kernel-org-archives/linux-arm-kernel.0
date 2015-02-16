From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Feb 2015 21:47:36 +0100
Subject: [PATCH 02/11] ARM: sunxi: always select RESET_CONTROLLER
In-Reply-To: <20150213090919.GB4567@lukather>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-3-git-send-email-arnd@arndb.de>
 <20150213090919.GB4567@lukather>
Message-ID: <2882517.xuoiQBUX5c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 February 2015 10:09:19 Maxime Ripard wrote:
> Hi Arnd,
> 
> On Thu, Feb 12, 2015 at 08:42:34PM +0100, Arnd Bergmann wrote:
> > A lot of drivers for mach-sunxi depend on RESET_CONTROLLER. While
> > this is selected for the drivers that have it, we keep running
> > into build errors in drivers that are used on both the SoCs with
> > and without a reset controller.
> > 
> > This patch moves the select statements into the common sunxi
> > Kconfig option, which solves multiple such problems.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Chen-Yu already submitted the exact same patch a few days ago:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322806.html
> 
> I was waiting for -rc1 to merge it, but I guess your way would work
> too.

It's not urgent, and since he came first, let's use that patch.

Feel free to add my 'Acked-by: Arnd Bergmann <arnd@arndb.de>' if you
haven't already applied it.

	Arnd
