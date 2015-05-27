From: jiri.prchal@aksignal.cz (=?UTF-8?B?SmnFmcOtIFByY2hhbA==?=)
Date: Wed, 27 May 2015 09:11:03 +0200
Subject: at91sam9: watchdog: period
In-Reply-To: <555DD282.3090508@aksignal.cz>
References: <55559D55.6020703@aksignal.cz>	<20150515172516.005e3a21@bbrezillon>	<5559865F.9010502@aksignal.cz>	<20150518092750.449d6c8c@bbrezillon>	<5559A029.9060007@aksignal.cz>	<555AA8F1.80100@atmel.com>	<20150519091442.675b1a98@bbrezillon>	<555AFBFD.3010506@aksignal.cz>	<20150519111402.747e8eb2@bbrezillon>	<555B07D0.4030000@aksignal.cz>
 <20150519120433.763a416e@bbrezillon> <555DD282.3090508@aksignal.cz>
Message-ID: <55656E07.9070102@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21.5.2015 14:41, Ji?? Prchal wrote:
> On 19.5.2015 12:04, Boris Brezillon wrote:
>>
>> Anyway, that does not explain why your system takes 61 secs to trigger
>> a reset (instead of 16 secs).
>> Can you try to revert this commit [1] ?
>>
>>
>> [1]https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/drivers/watchdog/at91sam9_wdt.c?id=d677772e1358924bf487cd833bdc4d50f3f6f64d
>>
>
> I reverted this commit: still 61s.
> By the way, between
> # [  109.117117] at91sam9_wdt: I will reset your machine !
> and
> RomBOOT
> is another 27s.
> Whole watchdog reboot sequence is about 90s!
> Slow clock is measured by counter as 32786Hz.

Is something new?
