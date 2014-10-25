From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 25 Oct 2014 11:55:11 +0200 (CEST)
Subject: [PATCH 1/2] clocksource: enable pxa_timer for SA-1100 platform
In-Reply-To: <10546062.ah0Qvxpsuh@wuerfel>
References: <1413377405-7503-1-git-send-email-dbaryshkov@gmail.com>
 <10546062.ah0Qvxpsuh@wuerfel>
Message-ID: <alpine.DEB.2.11.1410251154280.5308@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Oct 2014, Arnd Bergmann wrote:

> On Wednesday 15 October 2014 16:50:04 Dmitry Eremin-Solenikov wrote:
> > SA-11x0 platform used the same IP block as was used on PXA. Consequently
> > it makes sense to have only one driver. Enable pxa_timer clocksource for
> > StrongARM platform.
> > 
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> 
> Both patches look good to me.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Should we merge them through arm-soc or through the clocksource tree?

It touches arm, so please take it through arm-soc with my acked-by.

Thanks,

	tglx
