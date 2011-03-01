From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Mar 2011 20:04:20 +0100
Subject: [PATCH 1/2] ARM imx53: add pwm devices support
In-Reply-To: <AANLkTimCxkN1HKvhoMS7kHBngYxk6jNbz5qTssH4Fz-B@mail.gmail.com>
References: <1298972303-1010-1-git-send-email-b02280@freescale.com>
	<AANLkTimCxkN1HKvhoMS7kHBngYxk6jNbz5qTssH4Fz-B@mail.gmail.com>
Message-ID: <20110301190420.GW22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Tue, Mar 01, 2011 at 10:47:23AM -0300, Fabio Estevam wrote:
> On Tue, Mar 1, 2011 at 6:38 AM, Jason Chen <b02280@freescale.com> wrote:
> ...
> > - ? ? ? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
> > + ? ? ? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51() ||
> > + ? ? ? ? ? ? ? cpu_is_mx53()) {
> 
> Wouldn?t  "if (!cpu_is_mx1() && !cpu_is_mx21())" work here and make
> the if statement simpler?
Yes, but less future proof.  (Assume the next generation SoC is
different ...)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
