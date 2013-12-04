From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 Dec 2013 09:52:33 +0100
Subject: [PATCH v2] clocksource: sirf/marco+prima2: drop usage of
 CLOCK_TICK_RATE
In-Reply-To: <1385644882-450-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <529729D1.7030803@linaro.org>
 <1385644882-450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131204085233.GH29721@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

On Thu, Nov 28, 2013 at 02:21:22PM +0100, Uwe Kleine-K?nig wrote:
> Since CSR SiRF was converted to multi platform in cf82e0e (ARM: sirf:
> enable multiplatform support) the symbol CLOCK_TICK_RATE isn't the
> platform specific definition any more, but a global dummy value. There
> was no harm introduced in cf82e0e because the global value happens to
> match the old platform specific one, still this dummy value isn't
> intended to be used and will hopefully disappear soon, so introduce a
> local #define and use that instead.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Judging from your last comments I'd expect that you are happy with this
patch now. Can I please have your blessing to forward this patch in my
timex series to the arm-soc people?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
