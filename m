From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 16:20:19 +0200
Subject: [PATCH v3 7/7] ARM: sunxi: update the default ARCH_NR_GPIO for
 sunxi arch
In-Reply-To: <CACRpkdYT9HvG6dOVOEnBSNhRt847tdCsAU6E_dZLdFQEHntpKg@mail.gmail.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-8-git-send-email-boris.brezillon@free-electrons.com>
 <CACRpkdYT9HvG6dOVOEnBSNhRt847tdCsAU6E_dZLdFQEHntpKg@mail.gmail.com>
Message-ID: <201404221620.19519.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014, Linus Walleij wrote:
> On Thu, Apr 10, 2014 at 3:52 PM, Boris BREZILLON
> <boris.brezillon@free-electrons.com> wrote:
> 
> > The A31 SoC has PL and PM banks and thus increase the default ARCH_NR_GPIO.
> >
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Patch applied, and grrrr we need to get rid of these static #gpios defines
> in the long run.

Yes, that would be nice. I guess the gpio-descriptor framework should
have solved this, but we can't move everything over to that soon, right?

> ARM SoC folks: notice this hitting arch/arm/Kconfig, complain if it's
> problematic.

Thanks for letting us know about it.

	Arnd
