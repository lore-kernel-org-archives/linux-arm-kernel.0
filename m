From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Mon, 25 Nov 2013 12:07:49 +0530
Subject: [PATCH v2] irqchip: exynos-combiner: remove hard-coded irq_base
 value
In-Reply-To: <526444E5.5000405@samsung.com>
References: <1379937815-21746-1-git-send-email-chander.kashyap@linaro.org>
 <02c701ceba75$f95b1900$ec114b00$@org> <1949846.N3fAUHQ1Nx@flatron>
 <526444E5.5000405@samsung.com>
Message-ID: <CANuQgHFSNMV=RF8SHdZf3=gyNoXJWXEcevQ=DAOqUuZXSeugrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kikjin,

On 21 October 2013 02:32, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 10/18/13 02:53, Tomasz Figa wrote:
>>
>> Hi Kukjin,
>>
>> On Thursday 26 of September 2013 14:05:09 Kukjin Kim wrote:
>>>
>>> Chander Kashyap wrote:
>>>>
>>>> Replace irq_domain_add_simple with "irq_domain_add_linear" in order to
>>>> use linear irq domain, and to remove hardcoded irq_base_value.
>>>>
>>>> Signed-off-by: Chander Kashyap<chander.kashyap@linaro.org>
>>>> ---
>>>>
>>>> Changes since v1:
>>>>         - Replaced irq_domain_add_simple with irq_domain_add_linear,
>>>>
>>>>           as suggested by Tomasz
>>>>
>>>>   drivers/irqchip/exynos-combiner.c |   15 +++------------
>>>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> [snip]
>>>
>>>
>>> Looks nice to me, applied with Tomasz's review.
>>
>>
>> I don't see this patch in your tree. Did you apply it in the end?
>>
> Thanks for your gentle reminder.

I still can not see these patches in yours branches ?

>
> Applied.
> - Kukjin



-- 
with warm regards,
Chander Kashyap
