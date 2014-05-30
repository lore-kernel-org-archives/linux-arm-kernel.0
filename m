From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 May 2014 03:50:13 +0900
Subject: [RFC] Sort out S5P SoCs support in mainline
In-Reply-To: <5385C3CC.6010509@gmail.com>
References: <021f01cf7a61$69853e30$3c8fba90$@samsung.com>
 <13875033.1X6R9lksgc@wuerfel> <5385C3CC.6010509@gmail.com>
Message-ID: <5388D2E5.5080006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/14 20:09, Tomasz Figa wrote:
> On 28.05.2014 13:04, Arnd Bergmann wrote:
>> On Wednesday 28 May 2014 19:41:41 Kukjin Kim wrote:
>>> Hi all,
>>>
>>> I'm wondering who need to support following SoCs/boards in mainline.
>>>
>>> * S5P64X0/SMDK6440 and SMDK6450
>>> * S5PC100/SMDKC100
>>>
>>> If nobody is using them, how about to remove them from mainline?
>>
>> I talked about this with Tomasz Figa before, he also thinks they can be removed.
>> I don't see any reason to keep them myself, and will apply a patch to remove
>> them. Of course, if later somebody comes around who does need them, we can
>> revert the patch to bring them back.

Yeah, agreed.

>
> Or better, if later somebody comes around who does need them, we can add
> them properly, using Device Tree and existing generic code.
>
Of course.

> Anyway, for removal of both s5p64x0 and s5pc100:
>
> Acked-by: Tomasz Figa<t.figa@samsung.com>
>
> Actually I have played a bit with the code to see how much can be
> removed and ended up with following branch:
>
> https://github.com/tom3q/linux.git v3.17-cleanup
>
> Feel free to do _whatever_ you want with patches there.
>
OK, thanks.

Let me remove them from mainline when 3.16-rc1 is released...

- Kukjin
