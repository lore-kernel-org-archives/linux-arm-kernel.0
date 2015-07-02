From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Jul 2015 09:03:43 +0200
Subject: [RFC PATCH 00/15] pwm: add support for atomic update
In-Reply-To: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150702070343.GD11824@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

On Wed, Jul 01, 2015 at 10:21:46AM +0200, Boris Brezillon wrote:
> This series adds support for atomic PWM update, or ITO, the capability
> to update all the parameters of a PWM device (enabled/disabled, period,
> duty and polarity) in one go.
on first reading the subject of your series I thought it was about
asserting that the newly set config is active before the call to
pwm_config (et al) returns. That's a problem I addressed a few times in
the past. I wonder if it's only me or if a different wording should be
used for "update all parameters with a single function call".

But other than that I like the series.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
