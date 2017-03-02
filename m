From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 02 Mar 2017 23:13:53 +0800
Subject: [linux-sunxi] Re: [PATCH 2/3] clk: sunxi-ng: add support for PRCM
 CCUs
In-Reply-To: <20170302140931.tq3vpncln6giyjpr@lukather>
References: <20170301152236.MUXmRgOe@smtp1m.mail.yandex.net>
 <20170302140931.tq3vpncln6giyjpr@lukather>
Message-ID: <2899221488467633@web38j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



02.03.2017, 22:09, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Wed, Mar 01, 2017 at 08:22:13PM +0800, Icenowy Zheng wrote:
>> ?> I'm a bit worried by that to be honest. You claim to support the A31,
>> ?> yet jugdging by the current state of that code you never actually
>> ?> tested it on that SoC.
>> ?>
>> ?> What makes you say that the PRCM clocks are the same for the H3 and
>> ?> A64? We have to be sure, otherwise we might not be able to get the DT
>> ?> binding right from the very beginning, and we might not be able to fix
>> ?> it later.
>>
>> ?In fact, if we worry about this, we shouldn't make r-ccu, as
>> ?dedicated clocks are more easy to fix.
>>
>> ?For newer SoCs' PRCM, we never have enough documents, and Allwinner
>> ?have said that they cannot provide it. (I asked them for this.)
>>
>> ?The best solution is to implement mature enough dedicated clocks
>> ?before we convert to ccu.
>
> What do you mean by dedicated clocks?

The legacy form of clocks.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
