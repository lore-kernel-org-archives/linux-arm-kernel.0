From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Dec 2012 14:33:18 +0100
Subject: [PATCH 0/6] Add pinctrl driver for Allwinner A1X SoCs
In-Reply-To: <50C87D55.6020006@geeks.cl>
References: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
 <50C7AC79.5010006@geeks.cl> <50C84A46.2090503@free-electrons.com>
 <50C87D55.6020006@geeks.cl>
Message-ID: <50C8879E.5070401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/12/2012 13:49, Alejandro Mery a ?crit :
> On 12/12/12 10:11, Maxime Ripard wrote:
>> Hi Alejandro,
>>
>> Le 11/12/2012 22:58, Alejandro Mery a ?crit :
>>> On 10/12/12 23:08, Maxime Ripard wrote:
>>>> Hi everyone,
>>>>
>>>> This patch set adds a pinctrl driver for the IP found in the Allwinner
>>>> A10
>>>> and A13, and the SoC-specific bits for the A13. It also adds the
>>>> documentation
>>>> for the device tree bindings.
>>>
>>> Hi. I just wanted to comment that there are 3 known sun5i SoCs, not only
>>> the A13. The A10s and the A12 are also sun5i. For A10s and A13 there are
>>> datasheets available with the pin info. So please don't assume the A13's
>>> pins are "sun5i" pins, they are merely aw1626 (aka A13) pins.
>>
>> Ok, I will change the naming scheme to something like sun5i-a13. For the
>> other SoC codenames like sun4i, are you aware of several actual SoCs
>> using the same codename, or do we have only sun4i == A10?
> 
> the A10 is the only sun4i we know of, the A31 is the only sun6i we know
> of, and the A20 is the only sun7i we know of... they'll soon run out of
> numbers... :|
> 
> Also, to avoid confusions with their poorly chosen marketing name, you
> could use the internal chip name aw1623 for the A10 and aw1626 for the
> A13 instead. This value can be read from the BROM and it's commonly used
> in allwinner sources.

In what aspect are they poorly named? I'd really like to keep it as
understandable as possible, at least in the device tree.

I guess renaming the sun5i dtsi already there and all that relates to
the A13 to sun5i-a13 would remove that collision of names, don't you
think? Or am I missing something?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
