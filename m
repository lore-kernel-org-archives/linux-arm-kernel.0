From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Dec 2012 11:02:06 -0800
Subject: [PATCH V5 2/2] ASoC: SAMSUNG: Add DT support for i2s
In-Reply-To: <CAAgF-Bc3zSyhaMwSOy977PJ-PdtMfDXjFrTvpzETeHJAAQU3vQ@mail.gmail.com>
References: <1355395373-22058-1-git-send-email-padma.v@samsung.com>
 <1355395373-22058-3-git-send-email-padma.v@samsung.com>
 <20121219132414.2CF653E0AD7@localhost>
 <20121219170937.GV4985@opensource.wolfsonmicro.com>
 <CAAgF-Bc3zSyhaMwSOy977PJ-PdtMfDXjFrTvpzETeHJAAQU3vQ@mail.gmail.com>
Message-ID: <008401cddfad$ae2d19e0$0a874da0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padma Venkat wrote:
> 
> Hi,
> 
> On Wed, Dec 19, 2012 at 10:39 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, Dec 19, 2012 at 01:24:14PM +0000, Grant Likely wrote:
> >> On Thu, 13 Dec 2012 16:12:53 +0530, Padmavathi Venna
> <padma.v@samsung.com> wrote:
> >
> >> > +- compatible : "samsung,samsung-i2s"
> >
> >> Isn't that kind of redundant?  :-)
> >
> >> The format of the compatible strings should be "<vendor>,<part-
> number>-i2s".
> >> Please be specific about the part number that you're doing the binding
> >> for. For example; use "samsung,exynos4210-i2s" instead of
> "samsung,exynos-i2s".
> >
> > There are actually versioned IPs here (where the versions are used
> > publically in a few places) but it's not clearly documented which is
> > which.  It would be reasonable to use the IP versions here I think.
> 
> Samsung has three i2s drivers one for s3c24xx, one for s3c2412 and one
> for rest of the platforms. The above mentioned other platforms has
> Version 3/4/5 of i2s controllers. This dt binding is for for the i2s

Where is the version defined such as 3, 4, 5? So, what is the
"sound/soc/Samsung/s3c-i2s-v2.[ch]"?

> driver that has support for Version 3/4/5 of i2s controller. So
> "samsung,i2s-v5" is okay as compatible name? Please suggest me.
> 
I agree with using version here but we need some consensus about that.

- Kukjin
