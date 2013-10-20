From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 21 Oct 2013 06:02:29 +0900
Subject: [PATCH v2] irqchip: exynos-combiner: remove hard-coded irq_base
 value
In-Reply-To: <1949846.N3fAUHQ1Nx@flatron>
References: <1379937815-21746-1-git-send-email-chander.kashyap@linaro.org>
 <02c701ceba75$f95b1900$ec114b00$@org> <1949846.N3fAUHQ1Nx@flatron>
Message-ID: <526444E5.5000405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/18/13 02:53, Tomasz Figa wrote:
> Hi Kukjin,
>
> On Thursday 26 of September 2013 14:05:09 Kukjin Kim wrote:
>> Chander Kashyap wrote:
>>> Replace irq_domain_add_simple with "irq_domain_add_linear" in order to
>>> use linear irq domain, and to remove hardcoded irq_base_value.
>>>
>>> Signed-off-by: Chander Kashyap<chander.kashyap@linaro.org>
>>> ---
>>>
>>> Changes since v1:
>>> 	- Replaced irq_domain_add_simple with irq_domain_add_linear,
>>> 	
>>> 	  as suggested by Tomasz
>>>
>>>   drivers/irqchip/exynos-combiner.c |   15 +++------------
>>>   1 file changed, 3 insertions(+), 12 deletions(-)
> [snip]
>>
>> Looks nice to me, applied with Tomasz's review.
>
> I don't see this patch in your tree. Did you apply it in the end?
>
Thanks for your gentle reminder.

Applied.
- Kukjin
