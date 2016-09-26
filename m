From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 26 Sep 2016 21:29:26 +0200
Subject: [PATCH 0/4] kill get_clock_tick_rate()
In-Reply-To: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Mon, 19 Sep 2016 21:12:11 +0200")
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87twd2bgtl.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Hi,
>
> This serie aims at killing get_clock_tick_rate() from pxa and sa1100 and replace
> it by clock API calls.
>
> I'd like to have this reviewed and acked afterwards at least by :
>  - Russell for the mach-sa1100 and sa1100_wdt.c
>  - Stephen or Michael for the clk-pxa25x.c
>  - Thomas or Daniel for the clocksource part
>  - Wim for sa1100_wdt.c
>
> If the review converges, I'd also like to take it through the pxa/for-next tree,
> or alternatively Russell's tree if there is a dependency I'm not seeing, for
> v4.10 cycle.

Hi Russell,

Would you have time within the next 2 weeks to give this serie a review and
maybe an Ack from the sa1100 impacted parts (that would be patches 2, 3 and 4) ?

I can also resend the serie if it's easier in your workflow.

Cheers.

--
Robert
