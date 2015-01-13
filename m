From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 16:24:08 +0100
Subject: [PATCH] clocksource: sirf: remove unused variable
In-Reply-To: <54B52B39.1000607@linaro.org>
References: <1599190.ZYSE4SrQSK@wuerfel> <54B52B39.1000607@linaro.org>
Message-ID: <22227544.6odKQXu0TN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 January 2015 15:27:05 Daniel Lezcano wrote:
> On 01/13/2015 03:22 PM, Arnd Bergmann wrote:
> > A recent rework of the driver left an obviously unused variable
> > around, and now the compiler complains:
> >
> > clocksource/timer-marco.c: In function 'sirfsoc_marco_timer_init':
> > clocksource/timer-marco.c:260:6: warning: unused variable 'timer_div' [-Wunused-variable]
> >
> > Remove it.
> 
> Hi Arnd,
> 
> thanks for the fix. But this has been already fixed and merged in my 
> tree [1].

Ok, thanks. For some reason it has not shown up in Linux-next yet.
Is this branch supposed to be part of -next?

	Arnd
