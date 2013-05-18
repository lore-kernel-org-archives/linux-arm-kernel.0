From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat, 18 May 2013 20:30:21 +1200
Subject: [PATCH 4/4] MAINTAINERS: vt8500: Add clk-vt8500.c to MAINTAINERS
 file
In-Reply-To: <CABjd4Yw2LbnaUbQFW_bd_6WRGTA34-Vp_tUC2b4Jczj-MM8x1w@mail.gmail.com>
References: <1368825532-30917-1-git-send-email-linux@prisktech.co.nz>
 <1368825532-30917-5-git-send-email-linux@prisktech.co.nz>
 <CABjd4Yw2LbnaUbQFW_bd_6WRGTA34-Vp_tUC2b4Jczj-MM8x1w@mail.gmail.com>
Message-ID: <51973C1D.2080404@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/05/13 18:40, Alexey Charkov wrote:
> On 18 May 2013 01:18, "Tony Prisk" <linux@prisktech.co.nz> wrote:
>> This file has missed being added under ARM/VT8500 ARM ARCHITECTURE,
>> and is maintained along with the rest of the vt8500 arch code.
>>
>> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
>> ---
>>   MAINTAINERS |    1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3d7782b..5ab8ccb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1283,6 +1283,7 @@ M:        Tony Prisk <linux@prisktech.co.nz>
>>   L:     linux-arm-kernel at lists.infradead.org (moderated for
> non-subscribers)
>>   S:     Maintained
>>   F:     arch/arm/mach-vt8500/
>> +F:     drivers/clk/vt8500-vt8500.c
> This looks like a typo (clk vs. vt8500).
>
> Best,
> Alexey
>
eeek - oops.

Mike,

Disregard this patch - I will send a more complete one through arm-soc 
as there are other files missing as well.

Regards
Tony P
