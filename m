From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Wed, 12 Jan 2011 15:16:18 -0600
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
In-Reply-To: <20110112210241.GM24920@pengutronix.de>
References: <AANLkTimb3i4BiuXvnCdhXn-xnN==NjVg8MDLsDkuFwLC@mail.gmail.com>
	<20110112210241.GM24920@pengutronix.de>
Message-ID: <AANLkTimTMUUD86gMhSALLHUUcRM7PORCNs9iiU40R4Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2011/1/12 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> You're on ARM, too?

Yes, ARMv7 (zoom2).

>> > If it made no difference, then you know that something else (maybe in
>> > combination) is causing the problem.
>>
>> I tried to narrow it down using the dump and another thread mentioning
>> recent changes from "Nick" (might be Nick Piggin).
>>
>> Reverting: fs: rcu-walk aware d_revalidate method
>> commit: 34286d6662308d82aed891852d04c7c3a2649b16
> I found that one, too, in the meantime. ?Currently debugging that with
> tglx on irc.

OK, let me know if I can help.

Regards,

Omar
