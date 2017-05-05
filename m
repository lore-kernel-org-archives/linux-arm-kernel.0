From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 5 May 2017 10:32:28 +0200
Subject: [PATCH V4] ARM64: dts: hi6220-hikey: Add clock binding for the
 pmic mfd
In-Reply-To: <20170505074821.fgnkq6lggde6gdv2@dell>
References: <1493066439-6889-1-git-send-email-daniel.lezcano@linaro.org>
 <20170504220721.GB5252@mai> <20170505074821.fgnkq6lggde6gdv2@dell>
Message-ID: <20170505083228.GC5252@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 08:48:21AM +0100, Lee Jones wrote:
> On Fri, 05 May 2017, Daniel Lezcano wrote:
> 
> > On Mon, Apr 24, 2017 at 10:40:22PM +0200, Daniel Lezcano wrote:
> > > The hi655x PMIC provides the regulators but also a clock. The latter is missing
> > > in the definition and in the DT, thus it is no possible to enable the WiFi which
> > > depends on this clock.
> > > 
> > > The hi655x's clock has been added and the hi655x multifunction driver has
> > > updated with a clock-cell.
> > > 
> > > This patch adds the clock-cells for the PMIC in the DT and updates the
> > > documentation.
> > > 
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > ---
> > >  Changelog:
> > > 	v4:
> > > 	   - Added Acked-by's
> > > 	   - Updated the commit message with a better description
> > > ---
> > 
> > Hi Xu Wei,
> > 
> > a gentle reminder for this patch. Is it ok for you?
> 
> a) Pings aren't usually received well.  If you wish to remind
> maintainers of a patch's existence a [RESEND] is usually the most
> accepted method.
> b) There is usually little point (at least it's significantly reduced)
> in sending pings/resends whilst the merge-window is open.  Maintainers
> usually take this time to take a little breather (rest) from their
> duties.

This patch is the last one of a series which was already merged. As the
series has been resend and split with a different submission path, I just
wanted to make sure there were no confusion.

The sentence "a gentle reminder" is clumsy.

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
