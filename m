From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 9 Oct 2014 16:04:02 +0200
Subject: [PATCH v2 2/2] Documentation: dmaengine: Add a documentation
 for the dma controller API
In-Reply-To: <CAMuHMdUKk1kJwBndjiziRexOtXV-FN7568YJ9K_ZzVecTgmbuw@mail.gmail.com>
References: <1411746035-15882-1-git-send-email-maxime.ripard@free-electrons.com>	<1411746035-15882-2-git-send-email-maxime.ripard@free-electrons.com>	<7725507.nuHj4C7OxF@avalon>	<5433D9AF.8020508@atmel.com>	<20141007145226.GA17925@lukather>
 <CAMuHMdUKk1kJwBndjiziRexOtXV-FN7568YJ9K_ZzVecTgmbuw@mail.gmail.com>
Message-ID: <543695D2.1090504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2014 15:39, Geert Uytterhoeven :
> On Tue, Oct 7, 2014 at 4:52 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>>>>> +These various types will also affect how the source and destination
>>>>> +addresses change over time, as DMA_SLAVE transfers will usually have
>>>>> +one of the addresses that will increment, while the other will not,
>>>>> +DMA_CYCLIC will have one address that will loop, while the other, will
>>>>
>>>> s/the other,/the other/
>>>>
>>>>> +not change, etc.
>>>
>>> This is a little bit vague in my opinion. And usually, it is pretty
>>> implementation specific.
>>
>> Which is why we can't really be more precise. If you have any other
>> wording coming to your mind, I'm all for it :)
> 
> Perhaps:
> 
> Addresses pointing to RAM are typically incremented (or decremented) after
> each transfer. In case of a ring buffer, they may loop (DMA_CYCLIC).
> Addresses pointing to a device's register (e.g. a FIFO) are typically fixed.

+1 ;-)

Bye,
-- 
Nicolas Ferre
