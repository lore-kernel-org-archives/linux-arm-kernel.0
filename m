From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 26 May 2014 17:07:05 +0200
Subject: [GIT PULL] clockevents: new material for 3.16
In-Reply-To: <20140526134052.GA3790@lukather>
References: <537F214C.8000700@linaro.org>
 <20140526194512.032c6630@canb.auug.org.au> <53830ED9.9060001@linaro.org>
 <20140526134052.GA3790@lukather>
Message-ID: <1401116825.3400.27.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Montag, den 26.05.2014, 15:40 +0200 schrieb Maxime Ripard:
> On Mon, May 26, 2014 at 11:52:25AM +0200, Daniel Lezcano wrote:
> > On 05/26/2014 11:45 AM, Stephen Rothwell wrote:
> > >Hi all,
> > >
> > >On Fri, 23 May 2014 12:22:04 +0200 Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > >>
> > >>        clocksource: sun5i: Add support for reset controller
> > >
> > >This commit caused a build failure on arm in linux-next today ...
> 
> It's weird... of_reset_control_get has been merged in 3.15 by this
> commit fc0a5921561c71be2c334a335c1680f7930434d7 ("reset: Add
> of_reset_control_get"), and then the commit
> b424080a9e086e683ad5fdc624a7cf3c024e0c0f ("reset: Add optional resets
> and stubs") removed it, still in 3.15 (probably a mismerge).
> 
> Finally, Hans de Goede introduced it back in the following patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/246738.html
> 
> That should have shown up in one of 3.15-rc's according to:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/252317.html
> 
> Philipp, what's going on?

I have sent a pull request now.

regards
Philipp
