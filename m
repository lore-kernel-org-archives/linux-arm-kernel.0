From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 8 Nov 2018 16:13:19 +0100
Subject: [PATCH 1/4] pwm: Add new helper to initialize a pwm_state
 variable with defaults
In-Reply-To: <20181103142545.m3gdh6aqxpow7na5@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
 <20181029113337.GA9500@ulmo>
 <20181103142545.m3gdh6aqxpow7na5@pengutronix.de>
Message-ID: <20181108151319.nokv3pwaeteznm4b@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sat, Nov 03, 2018 at 03:25:45PM +0100, Uwe Kleine-K?nig wrote:
> On Mon, Oct 29, 2018 at 12:33:37PM +0100, Thierry Reding wrote:
> > On Fri, Oct 26, 2018 at 08:41:55PM +0200, Uwe Kleine-K?nig wrote:
> > > This helps to convert drivers from the legacy API to pwm_apply_state without
> > > having to make the aware of the configured polarity (and in some cases even
> > > period).
> > > 
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  include/linux/pwm.h | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > You're going to have to at least Cc me on patches 2 & 3 so that I can
> > see how you intend this to be used.
> 
> you were in To: for all four patches:
> 
>   patch 1: https://www.spinics.net/lists/linux-pwm/msg08178.html
>   patch 2: https://www.spinics.net/lists/linux-pwm/msg08179.html
>   patch 3: https://www.spinics.net/lists/linux-pwm/msg08180.html
>   patch 4: https://www.spinics.net/lists/linux-pwm/msg08181.html

Did you find those in your mailbox in the meantime? If google just
failed to put them in your inbox I can send you a bounce of 2 and 3 if
you want to. Just tell me (in irc if you want to).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
