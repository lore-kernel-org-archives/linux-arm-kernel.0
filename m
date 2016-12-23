From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 23 Dec 2016 12:06:55 -0600
Subject: [PATCH] ARM: keystone: dts: fix netcp clocks and add names
In-Reply-To: <94626755-2ef9-960c-d55a-f6c6d5c1adb7@oracle.com>
References: <20161208211139.3678-1-grygorii.strashko@ti.com>
 <94626755-2ef9-960c-d55a-f6c6d5c1adb7@oracle.com>
Message-ID: <5f9044ef-f387-7654-19c5-35b5bc9e9fb6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/08/2016 04:13 PM, Santosh Shilimkar wrote:
> On 12/8/2016 1:11 PM, Grygorii Strashko wrote:
>> From: Murali Karicheri <m-karicheri2@ti.com>
>>
>> Fix the pa clock to point to the clkpa which has clock rate of 1/3 of PA
>> PLL clock and add clock names.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
>
> Hi Arnd,
>
> Can you please pick this fix as well if possible in your
> non critical fixes branch ?

Sry, that I'm disturbing you, but was this patch applied somewhere?

-- 
regards,
-grygorii
