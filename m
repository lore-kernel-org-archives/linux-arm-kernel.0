From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 16 Jan 2015 21:17:47 +0530
Subject: [PATCH] arch: arm: mach-davinci: cdce949.c: Remove unused function
In-Reply-To: <CAKXHbyMc=jYXsZPCuRqP7zfgmhiER8M3=Z_9CdNoVBsV5f5jFQ@mail.gmail.com>
References: <1417906928-5728-1-git-send-email-rickard_strandqvist@spectrumdigital.se>	<54B64375.3070406@ti.com>
 <CAKXHbyMc=jYXsZPCuRqP7zfgmhiER8M3=Z_9CdNoVBsV5f5jFQ@mail.gmail.com>
Message-ID: <54B932A3.1040105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 04:26 AM, Rickard Strandqvist wrote:
> 2015-01-14 11:22 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
>> Hi Rickard,
>>
>> On Sunday 07 December 2014 04:32 AM, Rickard Strandqvist wrote:
>>> Remove the function cdce_set_rate() that is not used anywhere.
>>>
>>> This was partially found by using a static code analysis program called cppcheck.
>>>
>>> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
>>> ---
>>>  arch/arm/mach-davinci/cdce949.c              |   37 --------------------------
>>>  arch/arm/mach-davinci/include/mach/cdce949.h |    2 --
>>>  2 files changed, 39 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/cdce949.c b/arch/arm/mach-davinci/cdce949.c
>>> index abafb92..bccac4a 100644
>>> --- a/arch/arm/mach-davinci/cdce949.c
>>> +++ b/arch/arm/mach-davinci/cdce949.c
>>> @@ -212,43 +212,6 @@ static struct cdce_output output_list[] = {
>>>       [5]     = { cdce_y5_freqs, ARRAY_SIZE(cdce_y5_freqs) },
>>>  };
>>>
>>> -int cdce_set_rate(struct clk *clk, unsigned long rate)
>>
>> Without this function, this driver is of no use. I can see that CDCE949
>> support has remained unused for long time. I would rather see the entire
>> support including cdce949.c and cdce949.h and their references removed.
>>
>> Thanks,
>> Sekhar
>>
> 
> Hi
> 
> Sure, sounds nice :)
> I see if I have time to fix it this weekend.

Okay, I will wait till Monday before preparing my pull requests.

Thanks,
Sekhar
