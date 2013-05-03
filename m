From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 16:06:57 +0200
Subject: [PATCH 9/9] ARM: ux500: always select ABX500_CORE
In-Reply-To: <1500795.gEuGziRZET@wuerfel>
References: <1367528578-518090-1-git-send-email-arnd@arndb.de>
 <1883078.Smcmxe7hlB@wuerfel>
 <CACRpkdaNd0Ej-bM0MaXNdyHeWWH0CMi+mKKvtV5-891OFETtEA@mail.gmail.com>
 <1500795.gEuGziRZET@wuerfel>
Message-ID: <CACRpkdbDNoQSmFAyOMJRHSrnnuqpEfb0U9a7ZeaEztn1dAr_xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 3:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 03 May 2013 15:33:17 Linus Walleij wrote:

>> I lean toward selecting AB3100 and REGULATOR_AB3100
>> for the U300 actually.
>
> Should we still allow building them on other platforms then?
> Right now, these depend on the platforms that actually use
> the hardware, but in other places, we just allow everything to
> be built that compiles without errors.

Not in my opinion but IIRC in 2008 or so some other
subsystem maintainer beat us up for not allowing it
to build on every other platform, and the rationale given
was that allowin this to build on e.g. x86_64 gives some
nice compile coverage.

I don't know which argument wins :-)

> Is it theoretically possible to use the AB in combination with
> another (non-ST-Ericsson) digital baseband?

Theoretically (it's just a bunch of regulators etc when all comes
around), but it won't happen since these components
are not sold separately.

Yours,
Linus Walleij
