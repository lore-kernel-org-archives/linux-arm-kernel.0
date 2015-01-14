From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Wed, 14 Jan 2015 23:56:02 +0100
Subject: [PATCH] arch: arm: mach-davinci: cdce949.c: Remove unused function
In-Reply-To: <54B64375.3070406@ti.com>
References: <1417906928-5728-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <54B64375.3070406@ti.com>
Message-ID: <CAKXHbyMc=jYXsZPCuRqP7zfgmhiER8M3=Z_9CdNoVBsV5f5jFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-01-14 11:22 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> Hi Rickard,
>
> On Sunday 07 December 2014 04:32 AM, Rickard Strandqvist wrote:
>> Remove the function cdce_set_rate() that is not used anywhere.
>>
>> This was partially found by using a static code analysis program called cppcheck.
>>
>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>> ---
>>  arch/arm/mach-davinci/cdce949.c              |   37 --------------------------
>>  arch/arm/mach-davinci/include/mach/cdce949.h |    2 --
>>  2 files changed, 39 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/cdce949.c b/arch/arm/mach-davinci/cdce949.c
>> index abafb92..bccac4a 100644
>> --- a/arch/arm/mach-davinci/cdce949.c
>> +++ b/arch/arm/mach-davinci/cdce949.c
>> @@ -212,43 +212,6 @@ static struct cdce_output output_list[] = {
>>       [5]     = { cdce_y5_freqs, ARRAY_SIZE(cdce_y5_freqs) },
>>  };
>>
>> -int cdce_set_rate(struct clk *clk, unsigned long rate)
>
> Without this function, this driver is of no use. I can see that CDCE949
> support has remained unused for long time. I would rather see the entire
> support including cdce949.c and cdce949.h and their references removed.
>
> Thanks,
> Sekhar
>

Hi

Sure, sounds nice :)
I see if I have time to fix it this weekend.

Kind regards
Rickard Strandqvist
