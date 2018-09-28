From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 09:44:45 +0200
Subject: [PATCH] ARM: Assume maintainership of ARM reference designs
In-Reply-To: <20180927220439.GB20825@sirena.org.uk>
References: <20180927073733.11580-1-linus.walleij@linaro.org>
 <20180927220439.GB20825@sirena.org.uk>
Message-ID: <CAK8P3a21dCJuV7mmsVPboWXfxjEpBsiBh37nCk5WGRXWaMUHMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 12:04 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 27, 2018 at 09:37:33AM +0200, Linus Walleij wrote:
>
> > +F:   drivers/spi/spi-pl022.c
>
> The pl022 is actively used by *way* more than just the Arm reference
> platforms, it's a really popular IP though the driver is fairly feature
> complete at this point.  I'd like to at least see this split out as a
> separate thing rather than lumped in so that people don't discount the
> get_maintainers match as a false positive, though I'm totally fine with
> you taking it over.

The same logic probably applies to irq-vic.c, which is used on at least
five other platforms.

       Arnd
