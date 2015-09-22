From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 22 Sep 2015 16:48:09 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56016780.5080104@free.fr> (Mason's message of "Tue, 22 Sep 2015
 16:36:48 +0200")
References: <56001B78.2090001@free.fr> <2206647.QPrIpE2UC0@wuerfel>
 <56016780.5080104@free.fr>
Message-ID: <yw1xvbb2qwue.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

>> - the clock support should probably go to drivers/clk, unless this is
>>   a clocksource driver, which should go to drivers/clocksource. Add a
>>   DT binding spec. If you lack DT support, don't bother sending it,
>>   but send the rest anyway.
>
> I'll take a look at Mans' DT clock code, but I want to simplify it.

I wrote the clock driver using some incomplete documentation for 865x,
additional details gleaned from ancient vendor kernel source, plus trial
and error on an 8643 chip.  If I could have done it any simpler, I would
have.  I don't have any information on the 87xx series, so it's possible
the clock tree is completely different there.

-- 
M?ns Rullg?rd
mans at mansr.com
