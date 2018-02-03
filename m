From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 03 Feb 2018 15:21:42 +0800
Subject: [linux-sunxi] [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s
 compatible and add V3 one
In-Reply-To: <CAGRGNgXy5ZUdCj34jG5kJ8yLZLbcZie5tkvYP08sFpMmAjwPNg@mail.gmail.com>
References: <20180202180456.60378-1-icenowy@aosc.io>
 <20180202180456.60378-2-icenowy@aosc.io>
 <CAGRGNgXy5ZUdCj34jG5kJ8yLZLbcZie5tkvYP08sFpMmAjwPNg@mail.gmail.com>
Message-ID: <10F6ADAB-1E1E-4C14-8809-9471ABABBB8A@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?2?3? GMT+08:00 ??2:00:33, Julian Calaby <julian.calaby@gmail.com> ??:
>Hi Icenowy,
>
>On Sat, Feb 3, 2018 at 5:04 AM, Icenowy Zheng <icenowy@aosc.io> wrote:
>> The V3s is just a differently packaged version of the V3 chip, which
>has
>> a MAC with the same capability with H3. The V3s just doesn't wire out
>> the external MII/RMII/RGMII bus. (V3 wired out it).
>>
>> Drop the compatible string of V3s in the dwmac-sun8i driver, and add
>a
>> V3 compatible string, which has all capabilities.
>
>Aren't compatible strings technically API, so don't we need to support
>those that are out in the wild "forever"?
>
>Therefore shouldn't we leave the v3s variant around for compatibility
>with existing device trees?

You can run grep at arch/arm/boot/dts, this compatible
string is not used at all.

>
>Thanks,
