From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 02 Mar 2017 23:13:18 +0800
Subject: [linux-sunxi] Re: [PATCH 2/3] clk: sunxi-ng: add support for PRCM
 CCUs
In-Reply-To: <20170302140859.aqvwtgzxkdi2lqbc@lukather>
References: <20170301152220.MEgmqtKw@smtp2p.mail.yandex.net>
 <20170302140859.aqvwtgzxkdi2lqbc@lukather>
Message-ID: <3232491488467598@web22o.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



02.03.2017, 22:09, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Wed, Mar 01, 2017 at 08:17:39PM +0800, Icenowy Zheng wrote:
>> ?> I'm a bit worried by that to be honest. You claim to support the A31,
>> ?> yet jugdging by the current state of that code you never actually
>> ?> tested it on that SoC.
>>
>> ?I only claim to reserve possibility to extend the driver to support
>> ?A31, but I didn't claim it currently support A31.
>
> Well, you did call it sun6i.
>
> Please rename it, and we will consolidate in due time.

Then rename it back when it really gains support for A31?

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
