From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 00:45:01 +0900
Subject: [PATCHv5 0/5] Support new Exynos3250 SoC based on Cortex-A7 dual
 core
In-Reply-To: <5379ED6B.8060309@gmail.com>
References: <1399986308-23744-1-git-send-email-cw00.choi@samsung.com>
 <5374426B.6000505@samsung.com> <5379ECBF.9010706@gmail.com>
 <5379ED6B.8060309@gmail.com>
Message-ID: <537A26FD.2010808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/14 20:39, Tomasz Figa wrote:
>
>
> On 19.05.2014 13:36, Tomasz Figa wrote:
>> Hi Kukjin, Chanwoo,
>>
>> On 15.05.2014 06:28, Chanwoo Choi wrote:
>>> Dear Kukjin,
>>>
>>> Could you please pick following patches?
>>> - [PATCHv5 1/5] ARM: EXYNOS: Add Exynos3250 SoC ID
>>> - [PATCHv5 2/5] ARM: EXYNOS: Support secondary CPU boot of Exynos3250
>>
>> I'd say that [PATCHv5 5/5] ARM: dts: Add device tree sources for
>> Exynos3250 would be also useful. :)
>
> Aha, it is already applied. I should have checked in the tree first. Sorry.
>
No problem and I applied this without any reply...

I'm thinking the way to add soc_is_exynosOOOO() for new SoC and just 
holding it on including 5260, 5800 as well.

Any updates, I'll let you know.

Thanks,
Kukjin
