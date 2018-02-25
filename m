From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 25 Feb 2018 20:06:32 +1100
Subject: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
In-Reply-To: <E26547A5-F219-4310-B0E6-49AC3A700566@aosc.io>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-15-jernej.skrabec@siol.net>
 <CAGRGNgWgkfax2TUSjK4397i678gXTTLh80r2HWwTB6u0GM0Cuw@mail.gmail.com>
 <E26547A5-F219-4310-B0E6-49AC3A700566@aosc.io>
Message-ID: <CAGRGNgXosix84T3i4y0_ct4eiDSq9ef-dfo3soU54Or42bjxbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Sun, Feb 25, 2018 at 7:43 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2018?2?25? GMT+08:00 ??4:11:34, Julian Calaby <julian.calaby@gmail.com> ??:
>>Hi Jernej,
>>
>>On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec
>><jernej.skrabec@siol.net> wrote:
>>> Enable HDMI output on all boards which have HDMI connector.
>>>
>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>>> ---
>>>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts           | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25
>>++++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        | 24
>>+++++++++++++++++++++
>>>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         | 25
>>++++++++++++++++++++++
>>>  8 files changed, 199 insertions(+)
>>
>>As I understand it, the H2+ is just a slightly trimmed down H3. In
>>terms of HDMI support, the difference is that the H2+ can't output 4k.
>
> H2+ can OUTPUT 4K. The BSP restricts it to DECODE 4K. (And mainline won't have such restriction)

Interesting!

I'm getting my data from here: http://linux-sunxi.org/H3#Variants

So essentially what you're saying is that the H2+ is just a H3 with
less pins? (I'm assuming the "lack of gigabit mac" is effectively it
not having the required pins, i.e. GPIO bank D)

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
