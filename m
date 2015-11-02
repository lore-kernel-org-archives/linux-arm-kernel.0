From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Mon, 2 Nov 2015 15:40:56 +0530
Subject: [PATCH 5/7] clocksource/drivers/pxa_timer: Move the Kconfig rule
In-Reply-To: <563718C4.5050503@linaro.org>
References: <CAHLCerPX+bmNMNDFEW24GWXhmrCspfY=UYkhM54ORfoiB5Xfvw@mail.gmail.com>
 <563718C4.5050503@linaro.org>
Message-ID: <CAHLCerMthR1up5Z5hyzxMdo=J+nYPJ9UJF2R28Ws1kyxNAWmZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2015 at 1:33 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Amit,
>
> On 11/02/2015 08:44 AM, Amit Kucheria wrote:
>>
>> On Fri, Oct 30, 2015 at 4:22 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>> Instead of having the clocksource's Kconfig depending on the arch, let
>>> the
>>> arch to select the timer it needs.
>>
>>
>> Is this the prescribed way to do things nowadays? It leads to more
>> options showing up in 'make menuconfig'. Why do I need to see
>> CLKSRC_PXA if I'm not even compiling for ARCH_PXA (and not interesting
>> in COMPILE_TEST)?
>
>
> That won't happen.
>
> As the 'bool' has no string after, it won't show up in the menuconfig.

Nice, I didn't know that.

> Actually, with the next patch, only COMPILE_TEST will show it up in the
>
> Device Drivers->Clocksource drivers.

Thanks.
