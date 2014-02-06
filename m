From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 06 Feb 2014 11:24:21 +0900
Subject: [PATCH 11/18] extcon: max14577: Add max14577 prefix to muic_irqs
In-Reply-To: <20140205140450.GE5196@lee--X1>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-12-git-send-email-k.kozlowski@samsung.com>
 <52F18A08.6070409@samsung.com> <1391596810.3726.5.camel@AMDC1943>
 <20140205140450.GE5196@lee--X1>
Message-ID: <52F2F255.90705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2014 11:04 PM, Lee Jones wrote:
>>> Following patch has conflict on extcon-next branch(Linus 3.14-rc1)
>>> when apply patchset by using git am.
>>>
>>> [PATCH 11/18] extcon: max14577: Add max14577 prefix to muic_irqs
>>> [PATCH 12/18] extcon: max14577: Choose muic_irqs according to device type
>>> [PATCH 14/18] extcon: max14577: Add support for max77836
>>>
>>> The base commit of this patchset isn't mainline. You need to rebase this patchset 
>>> on extcon-next branch and please resend this patchset.
> 
> <snip>
> 
>> This patch patch (along with other) depends on previous rename patches
>> from this patchset:
>> [PATCH 07/18] mfd: max14577: Rename and add MAX14577 symbols to prepare
>> for max77836
>> http://article.gmane.org/gmane.linux.kernel/1636674
>>
>> I can resolve the conflict but then they will return on applying patch
>> 7/18.
>>
>> I think this patch may wait for a little until the rename-like patches
>> will be accepted.
>>
>> Can you ACK other patches touch extcon?
>>  - [PATCH 07/18] mfd: max14577: Rename and add MAX14577 symbols...
>>  - [PATCH 08/18] mfd: max14577: Rename state container to maxim_core
>>  - [PATCH 09/18] mfd: max14577: Add "muic" suffix to regmap and irq_chip
> 
> If you can obtain Acks for all of the patches, I can apply the entire
> patch-set to an immutable branch and issue a pull-request for the
> other maintainers to pull from.
> 

Hi Lee,

OK, I agree your opionion.
I'd like you to apply this patchset dependent on extcon subsytem
on your tree. I acked on following patchset and tested all of this patchset series.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

[PATCH 06/18] extcon: max14577: Change extcon name instead of static name according to device type
- I will delete this patch([PATCH 06/18]) on extcon-next branch.
[PATCH 07/18] mfd: max14577: Rename and add MAX14577 symbols...
[PATCH 08/18] mfd: max14577: Rename state container to maxim_core
[PATCH 09/18] mfd: max14577: Add "muic" suffix to regmap and irq_chip

[PATCH 11/18] extcon: max14577: Add max14577 prefix to muic_irqs
[PATCH 12/18] extcon: max14577: Choose muic_irqs according to device type
[PATCH 14/18] extcon: max14577: Add support for max77836

Thanks,
Chanwoo Choi
