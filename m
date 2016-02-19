From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 13:12:29 +0100
Subject: [PATCH V2 1/2] pinctrl: mediatek: Modify pinctrl bindings for
 mt7623
In-Reply-To: <56C6DF23.3060202@openwrt.org>
References: <1455866238-6102-1-git-send-email-blogic@openwrt.org>
 <CACRpkdYiQop2qDNuh4N2YZy2DTy9mOEyERro8hT4YogCPc2LGw@mail.gmail.com>
 <56C6DF23.3060202@openwrt.org>
Message-ID: <CACRpkdbWad9iZV9LYkvEFRZn_BQDtPEAy3JE0uuR569UwMJkHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 10:23 AM, John Crispin <blogic@openwrt.org> wrote:
> On 19/02/2016 10:03, Linus Walleij wrote:
>> On Fri, Feb 19, 2016 at 8:17 AM, John Crispin <blogic@openwrt.org> wrote:
>>
>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>> Cc: devicetree at vger.kernel.org
>>> ---
>>> please apply to the devel-mt2701 branch
>>>
>>> Changes in V2
>>> * make mt7623-pinfunc.h part of patch 1/2
>>> * make sure the list stays sorted
>>
>> Patch applied unless the Mediatek maintainers come with serious
>> remarks (I can always revert).
>>
>> Only minor comments from Yingjoe on the previous version so I guess
>> it is finished.
>>
>> MTK guys: do you even have this SoC? It appears MTK is churning out
>> a plethora of SoCs and then they land in the lap of the OpenWRT
>> developers before the MTK maintainers even start to look at it...
>>
>> Yours,
>> Linus Walleij
>>
>
> I am doing this work in close collaboration with MTK. It is contractual
> work. MTK is huge and has many BUs, one of them is WCN, formerly known
> as Ralink. I have supported their MIPS silicon for many years now so
> asking me to also take care of the Wireless SoCs based on ARM was the
> natural next step.

Awesome!

Keep doing what you're doing :)

Yours,
Linus Walleij
