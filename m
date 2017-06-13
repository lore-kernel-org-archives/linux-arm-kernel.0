From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 13 Jun 2017 15:45:30 +0200
Subject: [PATCH v4 2/2] arm: dts: Add Mediatek MT2701 i2c device node
In-Reply-To: <1497360189.930.42.camel@mhfsdcap03>
References: <1495784107-6711-1-git-send-email-jun.gao@mediatek.com>
 <1495784107-6711-3-git-send-email-jun.gao@mediatek.com>
 <1497268468.930.26.camel@mhfsdcap03>
 <dbfcfd5b-8812-8df2-40dc-42e889577c9a@gmail.com>
 <1497349452.930.36.camel@mhfsdcap03>
 <ba658a59-7ef9-2340-57fa-3bcefa3f47ed@gmail.com>
 <1497360189.930.42.camel@mhfsdcap03>
Message-ID: <8c0e441c-a3d9-9cfd-dbf9-556ad852a072@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13/06/17 15:23, Jun Gao wrote:
> On Tue, 2017-06-13 at 14:52 +0200, Matthias Brugger wrote:
>>
>> On 13/06/17 12:24, Jun Gao wrote:
>>> On Tue, 2017-06-13 at 11:36 +0200, Matthias Brugger wrote:
>>>>
>>>> On 12/06/17 13:54, Jun Gao wrote:
>>>>> On Fri, 2017-05-26 at 15:35 +0800, Jun Gao wrote:
>>>>>> From: Jun Gao <jun.gao@mediatek.com>
>>>>>>
>>>>>> Add MT2701 i2c device node.
>>>>>>
>>>>>> Signed-off-by: Jun Gao <jun.gao@mediatek.com>
>>>>>> ---
>>>>>>     arch/arm/boot/dts/mt2701-evb.dts | 42 ++++++++++++++++++++++++++++++++++++++++
>>>>>>     arch/arm/boot/dts/mt2701.dtsi    | 42 ++++++++++++++++++++++++++++++++++++++++
>>>>>>     2 files changed, 84 insertions(+)
>>>> [...]
>>>>>
>>>>> Dear Matthias,
>>>>>
>>>>> Could you take this patch together with
>>>>> [PATCH v4 1/2]dt-bindings: i2c: Add Mediatek MT2701 i2c binding ?
>>>>>
>>>>> Thanks!
>>>>>
>>>>
>>>> They are both included in the pull request I send [1] [2], or do I miss
>>>> something?
>>>>
>>>> Regards,
>>>> Matthias
>>>>
>>>> [1]
>>>> https://github.com/mbgg/linux-mediatek/commit/729b7f8dbdaff270c53052897ea06486221a49a2
>>>> [2]
>>>> https://github.com/mbgg/linux-mediatek/commit/c6c301d3ff7531894257acc4f4a73928a109bda1
>>>
>>> Dear Matthias,
>>>
>>> Would you mind to use the same style as follows in i2c-mtk.txt of [2]?
>>>
>>> "mediatek,mt2701-i2c", "mediatek,mt6577-i2c": for Mediatek MT2701
>>> "mediatek,mt6577-i2c": for Mediatek MT6577
>>> "mediatek,mt6589-i2c": for Mediatek MT6589
>>> "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for Mediatek MT7623
>>> "mediatek,mt8173-i2c": for Mediatek MT8173
>>>
>>>
>>> Thanks!
>>>
>>
>> You mean I should fix-up the patch to fit to the new binding
>> description? Or do you mean it should be MTxxxx instead of mtxxxx?
>>
>> Regards,
>> Matthias
> 
> Dear Matthias,
> 
> I mean fix-up the patch to fit to the new binding description. Is it OK?
> 

Then I can't see the difference between what you are asking for and what 
is already pushed to the repository. Please send a patch, that will make 
things clearer.

Regards,
Matthias
