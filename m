From: robh@kernel.org (Rob Herring)
Date: Mon, 22 Feb 2016 13:16:12 -0600
Subject: [PATCH] irqchip: irq-mvebu-odmi: new driver
In-Reply-To: <20160222091055.524c60a9@free-electrons.com>
References: <1455522162-16425-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025353.GD15973@rob-hp-laptop>
 <20160222091055.524c60a9@free-electrons.com>
Message-ID: <CAL_JsqJGoUW0jZKShosF_WskaDOj6aQnG=RbN+BQvTzAYjmB_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 2:10 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> FWIW, you're replying to the v1 of this patch, while v2 and v3 have
> already been posted, and v3 has already been merged by the irqchip
> maintainers:
>
>   http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?id=c27f29bbbf02168c9b1e8ba0fe7a8cb917e5a50f

Well, that's what you get when I'm working offline for a bit. :)

> On Sun, 21 Feb 2016 20:53:53 -0600, Rob Herring wrote:
>
>> > +- compatible              : The value here should contain "marvell,odmi-controller".
>>
>> SoC specific compatible too please.
>
> I can add that in a follow-up patch.

Please do.

>
>> > +- marvell,spi-base     : List of GIC base SPI interrupts, one for each
>> > +                         ODMI frame.
>>
>> Why not "interrupts" property?
>
> This has already been discussed with Arnd in a more recent iteration of
> the patch:
>
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409411.html
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409415.html
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/409430.html

Okay, it's fine.

Rob
