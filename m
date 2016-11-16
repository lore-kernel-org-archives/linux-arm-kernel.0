From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 16 Nov 2016 09:31:49 +0000
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <e78a288b-8bab-9441-2edb-6ec08e5103d7@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-2-wenpan@hisilicon.com> <5893354.6MrIxqzRoI@wuerfel>
 <e78a288b-8bab-9441-2edb-6ec08e5103d7@hisilicon.com>
Message-ID: <582C2785.2010804@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pan,

On 2016/11/16 8:56, wenpan wrote:
> Hi Marty?
> Does this confict with your patch? If not?I hope this could be merged first.  Besides could you tell me the link to your related patch?

This is the link: https://patchwork.kernel.org/patch/9334743/

BR,
Wei

> 
> Thanks,
> Pan
> 
> On 2016/10/17 21:48, Arnd Bergmann wrote:
>> On Monday, October 17, 2016 8:07:03 PM CEST Pan Wen wrote:
>>> Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.
>>>
>>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>>>
>>
>> Looks ok. I've added Marty Plummer to Cc, he was recently proposing
>> patches for Hi3520, which I think is closely related to this one.
>> Please try to work together so the patches don't conflict. It should
>> be fairly straightforward since you are basically doing the same
>> change here.
>>
>> 	Arnd
>>
>> .
>>
> 
> 
> .
> 
