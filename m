From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 15 Jan 2015 00:27:38 +0900
Subject: [RESEND PATCH] ARM: EXYNOS: Add exynos3250 suspend-to-ram support
In-Reply-To: <54B3A477.8080705@samsung.com>
References: <1420681838-4292-1-git-send-email-cw00.choi@samsung.com>
 <54B38989.4030700@kernel.org> <54B38B24.20804@samsung.com>
 <54B393B9.6060806@kernel.org> <54B3A477.8080705@samsung.com>
Message-ID: <54B68AEA.7090406@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 19:39, Chanwoo Choi wrote:
> Dear Kukjin,
> 
> On 01/12/2015 06:28 PM, Kukjin Kim wrote:
>> On 01/12/15 17:51, Chanwoo Choi wrote:
>>> Dear Kukjin,
>>>
>>> On 01/12/2015 05:44 PM, Kukjin Kim wrote:
>>>> On 01/08/15 10:50, Chanwoo Choi wrote:
>>>>> This patch adds the support for suspend-to-ram feature of Exynos3250 SoC.
>>>>> Exynos3250 don't contain the L2 cache.
>>>>>
>>>>> Cc: Kukjin Kim <kgene@kernel.org>
>>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>> ---
>>>>> Depend on:
>>>>> - v3.19-rc3
>>>>>
>>>> Chanwoo,
>>>>
>>>> Can you please let me know why this is depending on v3.19-rc3?
>>>> If I apply this on top of my tree not including some stuff between
>>>> v3.19-rc1 and v3.19-rc3, is there a problem?
>>>
>>> No problem.
>>> I'm sorry. It is my mistake about using meaning of dependency.
>>> This patch can be applied on v3.19-rc1. I just tested it on v3.19-rc3.
>>>
>> OK, applied.
> 
> Thanks for your apply.
> 
> I check this patch on your git repository on following:
> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/commit/?h=v3.20-next/update-samsung&id=e2fb3668567d0b70563cca0d1e350afd5053e4a3
> 
> Although this patch contains a little decription of patch,
> applied patch don't include any description of patch.
> 
> If you possible, please add the description of patch.
> 
You're right. Maybe I've missed the contents when I applied.

I've just restored your git log with small modification.

Thanks,
Kukjin
