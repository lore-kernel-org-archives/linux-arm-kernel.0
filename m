From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 17 Nov 2014 11:34:16 -0800
Subject: Pxa25x clocks for v3.19
In-Reply-To: <87d28ou3vt.fsf@free.fr>
References: <87d28ou3vt.fsf@free.fr>
Message-ID: <20141117193416.25314.75395@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2014-11-15 02:58:30)
> Hi Mike,
> 
> The pxa25x clocks v3 patch was posted here :
>     http://www.gossamer-threads.com/lists/linux/kernel/2046264
> 
> Even if it would remain dead code for v3.19, I'd need it to get in in that
> window so that I can activate at the same time pxa25x and pxa27x for v3.20, and
> prevent defconfigs breakage.
> 
> Could this code make it for v3.19 ?

Yes, I've applied it towards 3.19. I guess the missing piece is pxa3xx.
Do you have plans to tackle that for 3.20?

Thanks,
Mike

> 
> Cheers.
> 
> -- 
> Robert
> 
> PS: The code has been tested on lubbock and tosa hardwares.
