From: khilman@ti.com (Kevin Hilman)
Date: Tue, 03 May 2011 09:22:03 -0700
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com> (Linus
	Walleij's message of "Wed, 27 Apr 2011 15:18:55 +0200")
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com> <87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
Message-ID: <87y62ng3f8.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> 2011/4/26 Tony Lindgren <tony@atomide.com>:
>> * Linus Walleij <linus.walleij@linaro.org> [110423 01:32]:
>>> Since you'll probably be dependent on stuff happening in my patches
>>> to move stuff into drivers/gpio I'll be happy to carry the patches in my
>>> gpio-consolidation branch with Tony's ACKs if need be.
>>
>> Sounds good to me.
>
> I've just posted a patch series that moves "our" two GPIO drivers to
> drivers/gpio, they should serve as good inspiration... Tell me if I can
> help out, stack patches on top of this series and I'll carry them.

Great, thanks.

Are you OK with a move of the current OMAP GPIO drivers (rather ugly)
into drivers/gpio first, followed by the cleanup/restructure patches?

Kevin
