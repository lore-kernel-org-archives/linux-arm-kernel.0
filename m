From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 16 Mar 2018 14:11:19 +0100
Subject: [PATCH] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
In-Reply-To: <CAGb2v66bdH4kr=T=A0MNKShOCKkvp=+dWDZLskBoUJn_pUJDgw@mail.gmail.com>
References: <1521121410-17103-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20180316064731.muiw5yumhmfnwxg2@flea>
 <658946b9-4f49-ff24-3b84-da1eb9b7d9ad@micronovasrl.com>
 <CAGb2v66bdH4kr=T=A0MNKShOCKkvp=+dWDZLskBoUJn_pUJDgw@mail.gmail.com>
Message-ID: <e9498de3-8f5e-1273-954d-86384fbc02ab@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 16/03/2018 10:39, Chen-Yu Tsai ha scritto:
> On Fri, Mar 16, 2018 at 5:19 PM, Giulio Benetti
> <giulio.benetti@micronovasrl.com> wrote:
>> Hi Maxime,
>>
>> Il 16/03/2018 07:47, Maxime Ripard ha scritto:
>>>
>>> Hi Giulio,
>>>
>>> On Thu, Mar 15, 2018 at 02:43:30PM +0100, Giulio Benetti wrote:
>>>>
>>>> The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
>>>> for the needed pins.
>>>>
>>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>>
>>>
>>> Like we discussed last time, we only merge this kind of patches if
>>> there's an immediate user.
>>
>>
>> You're right.
>> In few time(I hope), I'm going to send dts for Linova1-4_3 and Linova1-7,
>> where I use those pins.
>> I have also to send 2 patches for 2 new panels for panel-simple.
>>
>> So I think I have to send 2 displays' patches before.
>> And a patchset for the 2 boards and rgb888 pins.
>>
>> One question: do I have to wait for panels' patches to applied and then send
>> patchset for boards dts?
>> Or can I send a unique patchset?
>> Because as I understand those patches should be applied to 2 different
>> repositories, right?
> 
> If none of them have been merged yet, it's best to send all of them
> as part of the same series, and to all parties involved. That way,
> people have the full picture of what you're trying to achieve when
> they review your patches. Unless your series is really big.
> 
> Maintainers will pick up patches that need to go through their trees.
> In general you don't need to do much coordination beyond pointing out
> whether the patches are safe to go in independently or there are
> dependencies that the maintainers need to be aware of.

Ok, now it's clear to me.
I've submitted only few patches till now,
so I didn't know about that.

Thank you very much

-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> 
> ChenYu
> 
