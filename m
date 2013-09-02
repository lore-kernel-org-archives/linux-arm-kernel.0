From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 2 Sep 2013 10:33:28 +0200
Subject: [PATCH v9 3/7] ARM: dts: enable hi4511 with device tree
In-Reply-To: <87d2ovs0fm.fsf@linaro.org>
References: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
 <1377695454-29109-4-git-send-email-haojian.zhuang@linaro.org>
 <87eh9c1i1o.fsf@linaro.org>
 <CAD6h2NRnjme1Hdc+5oMzrR8LYb7_rk13OeVfo0qFT=_jAbMoJg@mail.gmail.com>
 <87d2ovs0fm.fsf@linaro.org>
Message-ID: <CACRpkdbQKOdgOzSwK=TvkDdv-mp=Mn6sTTwtUoRUzi9=PrkqDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 4:44 PM, Kevin Hilman <khilman@linaro.org> wrote:

>>> Why is sysctrl and all of its children now under the clocks node?
>>>
>>> Kevin
>>
>> SMP registers and clock registers are sharing the system controller.
>
> That suggest the clock node should be a child of the sysctrl node, not
> the other way around.

That is the way we do it for the Nomadik in
arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
so a precedent exist. (SRC is system reset and control).

Yours,
Linus Walleij
