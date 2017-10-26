From: joonas.kylmala@iki.fi (=?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?=)
Date: Thu, 26 Oct 2017 15:06:00 +0000
Subject: Fwd: Re: [PATCH 1/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0
 from dts to dtsi
In-Reply-To: <5e5c4079-c150-2047-bdc2-e9cee5c2dfa1@iki.fi>
References: <5e5c4079-c150-2047-bdc2-e9cee5c2dfa1@iki.fi>
Message-ID: <98468b0f-5562-783b-dda5-9c90f1749ab7@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I accidentally forgot to CC this mailing list for the message so here it is.

Joonas

-------- Forwarded Message --------
Subject: Re: [PATCH 1/2] ARM: dts: sun8i: h3-h5: Move pinctrl of mmc0
from dts to dtsi
Date: Thu, 26 Oct 2017 14:57:00 +0000
From: Joonas Kylm?l? <joonas.kylmala@iki.fi>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Chen-Yu Tsai <wens@csie.org>, linux-sunxi at googlegroups.com, Icenowy
Zheng <icenowy@aosc.io>

Maxime Ripard:
> On Sun, Oct 22, 2017 at 12:19:56PM +0300, Joonas Kylm?l? wrote:
>> Most of the boards use the mmc0 pins and their attributes defined in
>> mmc0_pins_a and mmc0_cd_pin. Let's default to those by moving the
>> pinctrl attributes to the dtsi file. This makes it easier to modify
>> device trees in the future as there is only one place to change the
>> pinctrl attributes.
>>
>> As a side effect this patch also adds the detect pin of Orange Pi
>> Zero's mmc0 under pinctrl as it should have been there right from the
>> beginning.
> 
> We're actually in the process of removing those gpio pinctrl
> nodes. Could you make that while you're at it?

Sure. We are assuming that the bootloader will do the pin configuration?
