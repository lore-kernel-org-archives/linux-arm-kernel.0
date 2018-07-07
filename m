From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 07 Jul 2018 21:30:25 +0200
Subject: [PATCH v4 1/2] clk: pxa: export 32kHz PLL
References: <20180627194124.26366-1-robert.jarzmik@free.fr>
 <87d0w2gsa5.fsf@belgarion.home>
 <153091032623.143105.13689700534218065371@swboyd.mtv.corp.google.com>
Message-ID: <87d0vyg7xq.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@kernel.org> writes:

> Quoting Robert Jarzmik (2018-07-04 22:34:10)
>> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> 
>> > This clock is especially used by the RTC driver, so export it so that
>> > devicetree users can use it.
>> >
>> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> > ---
>> > Since v2: fix missing parenthesis in clk-pxa25x.c and clk-pxa3xx.c
>> 
>> Hi Michael and Stephen,
>> 
>> Could you have a look please ?
>> 
>
> I'll apply patch 1, and leave patch 2 to someone else?
As there is a dependency of patch 2 on patch 1, and with the Reviewed-by
provided by Rob, I'd appreciate you take it as well. If not, I'll queue it up
for the next cycle in my pxa tree.

Cheers.

-- 
Robert
