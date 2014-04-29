From: george.cherian@ti.com (George Cherian)
Date: Tue, 29 Apr 2014 09:58:36 +0530
Subject: [PATCH 5/6] ARM: AM43xx: clk: Change the cpts ref clock source
 to dpll_core_m5 clk
In-Reply-To: <20140428161856.GB4266@netboy>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
 <1398658225-25873-6-git-send-email-george.cherian@ti.com>
 <20140428071034.GB4380@netboy> <535E4FDC.70306@ti.com>
 <20140428161856.GB4266@netboy>
Message-ID: <535F2A74.9060908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 4/28/2014 9:48 PM, Richard Cochran wrote:
> On Mon, Apr 28, 2014 at 06:25:56PM +0530, George Cherian wrote:
>> In beagle bone white (AM335x)  CPTS has a choice of 2 clocksource
>> -dpll_core_m5_ck
>> -dpll_core_m4_ck
>> and by default  dpll_core_m5_ck is used. Where as in AM437x the
>> default clocksource used is dpll_core_m4_ck .
> Is your patch changing the default clock for am335x?
No
>
> If yes, it shouldn't.
> If no, then the patch description should say so.
I am modifying the file

drivers/clk/ti/clk-43xx.c for am33xx its drivers/clk/ti/clk-33xx.c

> Thanks,
> Richard
>
>   


-- 
-George
