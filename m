From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Fri, 20 Jan 2017 09:47:12 +0800
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <59a9b91c-d7be-cf3a-d461-252cb493d61c@gmail.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-2-wenpan@hisilicon.com> <5893354.6MrIxqzRoI@wuerfel>
 <2fcf5a5f-8935-c4f0-a034-c8a72dc2be0f@hisilicon.com>
 <fb89c03e-ea67-d339-b222-6f0e08988563@gmail.com>
 <cfecdd06-90c4-6e9c-30cb-59b1ee70e8a5@hisilicon.com>
 <59a9b91c-d7be-cf3a-d461-252cb493d61c@gmail.com>
Message-ID: <7bfc8ca6-696b-a1f4-cf9a-e928112ecf35@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/12/15 4:06, Marty Plummer wrote:
> On 12/12/2016 01:11 AM, Jiancheng Xue wrote:
>>
>>
>> On 2016/12/9 23:07, Marty Plummer wrote:
>>> On 12/04/2016 08:03 PM, Jiancheng Xue wrote:
>>>> Hi Arnd,
>>>>
>>>> On 2016/10/17 21:48, Arnd Bergmann wrote:
>>>>> On Monday, October 17, 2016 8:07:03 PM CEST Pan Wen wrote:
>>>>>> Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.
>>>>>>
>>>>>> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
>>>>>>
>>>>>
>>>>> Looks ok. I've added Marty Plummer to Cc, he was recently proposing
>>>>> patches for Hi3520, which I think is closely related to this one.
>>>>> Please try to work together so the patches don't conflict. It should
>>>>> be fairly straightforward since you are basically doing the same
>>>>> change here.
>>>>>
>>>> Marty hasn't give any replies about this thread until now. I reviewed
>>>> the patch for Hi3520. And I think this patch won't conflict with Hi3520.
>>>> Could you help us to ack this patch?
>>>>
>>>> Thanks,
>>>> Jiancheng
>>>>
>>>>
>>> Hello all
>>>
>>> Sorry for my lack of activity, I've just been very busy lately with real
>>> world considerations (well, real world but related to this; I have
>>> another board based on hi3521a I've been tinkering with, trying to get
>>> the manuf. to release gpl source via the sfconfservancy). I've not given
>>> up on the project, however, since devices like this really need updates
>>> in light of the recent botnets targeting devices of this sort as
>>> manpower.
>>
>> Do you have any objections to this patch?  If not, I hope this patch can
>> be merged in 4.10.  Thank you.
>>
>> Regards,
>> Jiancheng
>>
>>
>>
> I have no objections. It looks like it might make my job a bit easier in
> the end. I need to go ahead and rebase my patches anyways and fix up
> earlier concerns raised about them, so go right ahead.
> 
Hi Arnd,

Could this patch be accepted?  Any further comments will be appreciated.

Regards,
Jiancheng
