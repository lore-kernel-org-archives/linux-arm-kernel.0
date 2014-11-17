From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 17 Nov 2014 21:06:12 +0100
Subject: Pxa25x clocks for v3.19
In-Reply-To: <20141117193416.25314.75395@quantum> (Mike Turquette's message of
 "Mon, 17 Nov 2014 11:34:16 -0800")
References: <87d28ou3vt.fsf@free.fr> <20141117193416.25314.75395@quantum>
Message-ID: <874mtx8udn.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Turquette <mturquette@linaro.org> writes:

> Quoting Robert Jarzmik (2014-11-15 02:58:30)
>> Hi Mike,
>> 
>> The pxa25x clocks v3 patch was posted here :
>>     http://www.gossamer-threads.com/lists/linux/kernel/2046264
>> 
>> Even if it would remain dead code for v3.19, I'd need it to get in in that
>> window so that I can activate at the same time pxa25x and pxa27x for v3.20, and
>> prevent defconfigs breakage.
>> 
>> Could this code make it for v3.19 ?
>
> Yes, I've applied it towards 3.19. I guess the missing piece is pxa3xx.
> Do you have plans to tackle that for 3.20?
Rather for 3.21, I don't have any pxa3xx board, and the clock tree is more
complicated. But yes, I do have a plan for that in the near future.

AFAIK, there is not such dependancy between pxa3xx and other variants, contrary
to what happens between pxa25x and pxa27x. That gives me a bit of time to
breathe.

Ah, and thanks for the clk-next clk-fixes cherry-picks.

Cheers.

--
Robert
