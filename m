From: khilman@ti.com (Kevin Hilman)
Date: Thu, 21 Apr 2011 10:09:32 -0700
Subject: [PATCH] OMAP2+: powerdomain: fix typo: lose context --> loose
	context
In-Reply-To: <alpine.DEB.2.00.1104210851500.991@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 21 Apr 2011 09:35:20 -0600 (MDT)")
References: <1303345531-8435-1-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1104210851500.991@utopia.booyaka.com>
Message-ID: <87tydr1qgj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> On Wed, 20 Apr 2011, Kevin Hilman wrote:
>
>> Before we get any users of this function, fix the name (and comments)
>> to use loose instead of lose.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Applies to v2.6.39-rc4
>> 
>>  arch/arm/mach-omap2/powerdomain.c |    6 +++---
>>  arch/arm/mach-omap2/powerdomain.h |    2 +-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>> index 9af0847..ec3423f 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -960,18 +960,18 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
>>  }
>>  
>>  /**
>> - * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
>> + * pwrdm_can_ever_loose_context - can this powerdomain ever loose context?
>
> 'lose' is correct in this case,. It's derived from the idiom 'context 
> loss'.  more broadly, 'loose' implies a strong sense of agency on the part 
> of whatever is doing the 'loosing,' whereas 'lose' does not (it's the PRCM 
> that causes the powerdomain to lose context, not the powerdomain itself - 
> the powerdomain's logic/memory context is subject to the PRCM's whim)

After a dictionary lookup, I guess you're right.  I guess I've been
spelling that wrong for a while, and it seems I'm not the only one:

  http://www.elearnenglishlanguage.com/difficulties/looselose.html

Thanks for the English lesson.  ;)

Kevin
