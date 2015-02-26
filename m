From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Feb 2015 11:43:04 +0100
Subject: [PATCH v2 02/18] ARM: ARMv7M: Enlarge vector table to 256 entries
In-Reply-To: <CALszF6B6A=de_TK0e-iJHuW4MfD9xbd-yHZHaD-JmZXwZ9CW2A@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1424455277-29983-3-git-send-email-mcoquelin.stm32@gmail.com>
 <20150220194756.GS19388@pengutronix.de>
 <CALszF6CB9YU7ashQ-y_zx58Mkf=sbrBfa2dAOdQm7FkmcuE7PA@mail.gmail.com>
 <CALszF6B6A=de_TK0e-iJHuW4MfD9xbd-yHZHaD-JmZXwZ9CW2A@mail.gmail.com>
Message-ID: <20150226104304.GK7789@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 11:29:52AM +0100, Maxime Coquelin wrote:
> 2015-02-23 11:33 GMT+01:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> > 2015-02-20 20:47 GMT+01:00 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> >> Who do you target to apply this series?
> >
> > I guess it should go through Russell's Patch Tracking System?
> 
> Sorry, I answered your question too quickly.
> I meant this patch should go through Russell's Patch Tracking System.
> 
> For the other patches, I think it should be picked by their respective
> maintainers.
> Or I can create an immutable tag (on github or kernel.org?) that will
> be merged by the different sub-systems?
> What would you advise?
Depends on the interdependencies of your patches. If each maintainer can
just pick up the patches affecting his area on top of (say) 4.0-rc1 that
would be good.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
