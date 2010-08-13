From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Aug 2010 10:46:01 +0200
Subject: [PATCH] ARM: pxa/pwm: Make id const in pwm_probe()
In-Reply-To: <AANLkTinQK3pddET6eL=JR2aOY4eXTjgO4NFy63JhZo_o@mail.gmail.com>
References: <1281593908-30448-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTinQK3pddET6eL=JR2aOY4eXTjgO4NFy63JhZo_o@mail.gmail.com>
Message-ID: <20100813084601.GA27637@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 04:36:57PM +0800, Eric Miao wrote:
> 2010/8/12 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > This fixes the compiler warning:
> >
> > ? ? ? ?arch/arm/plat-pxa/pwm.c: In function 'pwm_probe':
> > ? ? ? ?arch/arm/plat-pxa/pwm.c:179: warning: initialization discards qualifiers from pointer target type
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Ack.
That means patch system?

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
