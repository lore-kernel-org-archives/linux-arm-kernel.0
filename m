From: yong.shen@linaro.org (Yong Shen)
Date: Wed, 1 Dec 2010 14:07:39 +0800
Subject: [PATCH] make mc13783 code generic
In-Reply-To: <20101130151725.GN7403@rakim.wolfsonmicro.main>
References: <AANLkTimfDHRXZjB5=Ld9YSFzqh-hVWUTy-TQFV=GEaGA@mail.gmail.com>
	<1291110118.3235.27.camel@realization>
	<20101130143247.GI20449@pengutronix.de>
	<20101130145517.GF32368@sirena.org.uk>
	<20101130151540.GN20449@pengutronix.de>
	<20101130151725.GN7403@rakim.wolfsonmicro.main>
Message-ID: <AANLkTikonT687xucGF1AoRRFATeztNnsyUoqaiXBv=YB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

good hints.
./scripts/get_maintainer.pl 0001-make-mc13783-code-generic.patch
--nogit-fallback gives me below information which I am going to use
next time.


Liam Girdwood <lrg@slimlogic.co.uk>
Mark Brown <broonie@opensource.wolfsonmicro.com>
linux-kernel at vger.kernel.org

2010/11/30 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Nov 30, 2010 at 04:15:40PM +0100, Uwe Kleine-K?nig wrote:
>> On Tue, Nov 30, 2010 at 02:55:17PM +0000, Mark Brown wrote:
>
>> > interest in most of the code he's touching. ?If you use the --nogit
>> > option (which is the default with current -next) get_maintainer.pl is a
>> > bit safer but you then need to think about people who might be actively
>
>> I tried --nogit some time ago, but it still used git. ?After looking
>> again I probably should have passed --nogit-fallback, too.
>
> Oh, erk - hadn't noticed the fallback stuff. ?The general point we're
> both making does still stand, get_maintainer is a useful starting point
> but should never be considered gospel.
>
