From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 14:47:16 +0100
Subject: AB8500 Regulators
In-Reply-To: <5017CEE4.5010602@linaro.org>
References: <501690F7.2010904@linaro.org>
 <20120730152618.GI4468@opensource.wolfsonmicro.com>
 <5016B70A.1030601@linaro.org>
 <20120730174831.GP4468@opensource.wolfsonmicro.com>
 <50179B64.60209@linaro.org>
 <20120731110830.GY4468@opensource.wolfsonmicro.com>
 <5017CEE4.5010602@linaro.org>
Message-ID: <20120731134716.GL4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 01:26:12PM +0100, Lee Jones wrote:
> On 31/07/12 12:08, Mark Brown wrote:

> >>- I now know how the changing voltage API works
> >>   - What I don't know is where we'd call it from to initialise them
> >>   - Can we do that from the ab8500 regulator driver's init() or probe()?

> >I'm surprised you've managed to miss the existing interfaces:

> >    include/linux/regulator/machine.h
> >    Documentation/devicetree/bindings/regulator/regulator.txt

> I saw the interfaces, I just don't know what's the correct thing to
> do. I'm leaving Device Tree for the moment. I'm more concerned about
> addressing the problem in the AB8500 Regulator Driver and it's
> Platform counterpart.

> The only thing of interest that I could see was the regulator_init()
> call-back. Is this what you were alluding to in the first link?

No.  apply_uV.

> I guess we're going to have to take a rain-check until I can find
> someone who can translate the documentation for me. I just can't
> seem to find even a small paragraph or such which can provide me
> with enough information to make any decisions.

It does seem that way, yes.
