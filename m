From: b32955@freescale.com (Huang Shijie)
Date: Wed, 12 Sep 2012 15:00:02 +0800
Subject: [PATCH 6/9] mtd: gpmi: simplify the setting DLL code
In-Reply-To: <504F7E10.8030406@gmail.com>
References: <1347344231-10295-1-git-send-email-b32955@freescale.com>
 <1347344231-10295-7-git-send-email-b32955@freescale.com>
 <504F7E10.8030406@gmail.com>
Message-ID: <505032F2.4090102@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?09?12? 02:08, Vikram Narayanan ??:
>>
>> /*
>> * After we enable the GPMI DLL, we have to wait 64 clock cycles before
>> - * we can use the GPMI.
>> - *
>> - * Calculate the amount of time we need to wait, in microseconds.
>> + * we can use the GPMI. Calculate the amount of time we need to wait,
>> + * in microseconds.
>> */
>> clock_period_in_ns = 1000000000 / clk_get_rate(r->clock[0]);
>
> NSEC_PER_SEC macro in the above statement?
>
> Don't curse me for commenting about the code that you've not written. 
> As this patch does some cleanups, I'm suggesting this. 
I finally get what's your meaning. thanks for you review :)

I really appreciate it.


Best Regards
Huang Shijie
