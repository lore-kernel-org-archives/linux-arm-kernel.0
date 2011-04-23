From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 23 Apr 2011 10:35:47 +0200
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <20110421054221.GF5918@atomide.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com> <87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
Message-ID: <BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/21 Tony Lindgren <tony@atomide.com>:
> * Kevin Hilman <khilman@ti.com> [110421 02:56]:

>> > - Move it to drivers/gpio
>> >
>> > - Further consolidate with whatever common GPIO code might
>> > ? be coming up.
>>
>> Is the above order required?
>
> Yes please. Otherwise we'll have more of the "crazy churn" in
> arch/arm/*omap*/ and the runtime PM patches should apply easily
> in drivers/gpio too.

Since you'll probably be dependent on stuff happening in my patches
to move stuff into drivers/gpio I'll be happy to carry the patches in my
gpio-consolidation branch with Tony's ACKs if need be.

Yours,
Linus Walleij
