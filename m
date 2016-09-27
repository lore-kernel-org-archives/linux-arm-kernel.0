From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 27 Sep 2016 20:46:12 +0200
Subject: [PATCH 0/4] kill get_clock_tick_rate()
In-Reply-To: <87twd2bgtl.fsf@belgarion.home> (Robert Jarzmik's message of
 "Mon, 26 Sep 2016 21:29:26 +0200")
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
 <87twd2bgtl.fsf@belgarion.home>
Message-ID: <87wphx9o5n.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:
>> Hi,
>>
>> This serie aims at killing get_clock_tick_rate() from pxa and sa1100 and replace
>> it by clock API calls.
>>
>> I'd like to have this reviewed and acked afterwards at least by :
>>  - Russell for the mach-sa1100 and sa1100_wdt.c
>>  - Stephen or Michael for the clk-pxa25x.c
>>  - Thomas or Daniel for the clocksource part
>>  - Wim for sa1100_wdt.c

Thanks to all for tests and acks, queued to pxa/for-next.

Cheers.

--
Robert
