From: john.ogness@linutronix.de (John Ogness)
Date: Fri, 24 Sep 2010 10:13:36 +0200
Subject: [PATCH v2] mx35: Fix boot ROM hang in internal boot mode
Message-ID: <80aan7sgnj.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-08-13, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
>> In my tests on an mx35pdk board, I found these three clocks being the
>> minimum set of additional clocks that need to be turned on. That
>> means, if you turn off any of the three, it won't boot anymore.
>> 
>> As a sidenote, it should be clear that this patch is a workaround for
>> a serious chip bug of the MX35.
>
> If you're conviced this is a chip problem, did you consider to contact
> FSL about it?

Freescale has responded to my inqueries about the boot ROM issue:

MX51EVK, MX508ARM2, MX25PDK boards also do this. Freescale has no plans
to change the MX35 ROM code.

John
