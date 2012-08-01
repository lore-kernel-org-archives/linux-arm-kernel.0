From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 1 Aug 2012 11:42:12 -0400
Subject: [PATCH 06/22] ARM: LPAE: use phys_addr_t in alloc_init_pud()
In-Reply-To: <50191C46.4090902@mvista.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-7-git-send-email-cyril@ti.com>
 <50191C46.4090902@mvista.com>
Message-ID: <50194E54.5040909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/1/2012 8:08 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 01-08-2012 3:04, Cyril Chemparathy wrote:
>
>> From: Vitaly Andrianov <vitalya@ti.com>
>
>> This patch fixes the alloc_init_pud() function to use phys_addr_t
>> instead of
>> unsigned long when passing in the phys argument.
>
>> This is an extension to commit
>> 97092e0c56830457af0639f6bd904537a150ea4a, which
>
>     Please also specify that commit's summary in parens.

Thanks Sergei.  Will do so.  I'm assuming you meant headline and not 
summary.

>
>> applied similar changes elsewhere in the ARM memory management code.
>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>
> WBR, Sergei
>

-- 
Thanks
- Cyril
