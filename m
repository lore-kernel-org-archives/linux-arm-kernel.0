From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Tue, 21 Jul 2015 17:27:39 +0300
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <CACRpkdY2i2M27gP_fXawkFrC_GFgWaKr5rEn6d47refNPiEk=g@mail.gmail.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <CACRpkdaRJJjCXR=vK1M2YhR26JZfGoBB+jcqz8r2MhERfxRzqA@mail.gmail.com>
 <CAPAsAGy-r8Z2N09wKV+e0kLfbwxd-eWK6N5Xajsnqq9jfyWqcQ@mail.gmail.com>
 <CACRpkdZmHLMxosLXjyOPdkavo=UNzmTcHOLF5vV4cS1ULfbq6A@mail.gmail.com>
 <CAPAsAGw-iawTpjJh66rQN5fqBFT6UBZCcv2eKx7JTqCXzhzpsw@mail.gmail.com>
 <CACRpkdY2i2M27gP_fXawkFrC_GFgWaKr5rEn6d47refNPiEk=g@mail.gmail.com>
Message-ID: <55AE56DB.4040607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2015 01:36 PM, Linus Walleij wrote:
> On Wed, Jun 17, 2015 at 11:32 PM, Andrey Ryabinin
> <ryabinin.a.a@gmail.com> wrote:
>> 2015-06-13 18:25 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>>>
>>> On Fri, Jun 12, 2015 at 8:14 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>>> 2015-06-11 16:39 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:
>>>>> On Fri, May 15, 2015 at 3:59 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
>>>>>
>>>>>> This patch adds arch specific code for kernel address sanitizer
>>>>>> (see Documentation/kasan.txt).
>>>>>
>>>>> I looked closer at this again ... I am trying to get KASan up for
>>>>> ARM(32) with some tricks and hacks.
>>>>>
>>>>
>>>> I have some patches for that. They still need some polishing, but works for me.
>>>> I could share after I get back to office on Tuesday.
>>>
>>> OK! I'd be happy to test!
>>>
>>
>> I've pushed it here : git://github.com/aryabinin/linux.git kasan/arm_v0
>>
>> It far from ready. Firstly I've tried it only in qemu and it works.
> 
> Hm what QEMU model are you using? I tried to test it with Versatile
> (the most common) and it kinda boots and hangs:
> 

I used vexpress. Anyway, it doesn't matter now, since I have an update
with a lot of stuff fixed, and it works on hardware.
I still need to do some work on it and tomorrow, probably, I will share.
