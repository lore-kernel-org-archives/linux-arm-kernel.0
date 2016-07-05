From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jul 2016 17:37:37 +0200
Subject: [PATCH 03/11] ASoC: ab8500-codec: remove platform data based probe
In-Reply-To: <CACRpkdZ7JW7iBzwL_7cY928Fp+CUNwPHQ6D8--CXvoLq7LMZAA@mail.gmail.com>
References: <1467722710-1577-1-git-send-email-linus.walleij@linaro.org>
 <20160705134445.GV6247@sirena.org.uk>
 <CACRpkdZ7JW7iBzwL_7cY928Fp+CUNwPHQ6D8--CXvoLq7LMZAA@mail.gmail.com>
Message-ID: <11904780.Lu8lhWhFex@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 5, 2016 5:22:22 PM CEST Linus Walleij wrote:
> On Tue, Jul 5, 2016 at 3:44 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Jul 05, 2016 at 02:45:02PM +0200, Linus Walleij wrote:
> >
> >> Mark: if this makes sense to you, please provide an ACK so Arnd
> >> can merge this cleanup.
> >
> > I'm still not clear what dependency this has on anything elsein the
> > series.
> 
> None whatsoever if I'm reading it right. The series also compiles
> fine without it.
> 
> Do you prefer to apply it to the ASoC tree? I can drop
> it from this series.

I was originally planning to drop the entire ab8500_platform_data
structure and ab8500_codec_platform_data, which requires this change,
but from all I can see are right that in the current version of the
series that is not required.

	Arnd
