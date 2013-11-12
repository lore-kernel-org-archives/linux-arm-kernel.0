From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 18:08:57 +0100
Subject: [PATCH 1/7] ARM: sa1100: switch to MULTI_IRQ_HANDLER
In-Reply-To: <CAL_JsqJz6deAwLd1i+S-H59AQep3LWBosSRtzOSa+EQeeEd7VA@mail.gmail.com>
References: <1384264061-6174-1-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqJz6deAwLd1i+S-H59AQep3LWBosSRtzOSa+EQeeEd7VA@mail.gmail.com>
Message-ID: <CACRpkdZHzv7x+BR1Z2QRoM9U4_UBTYWXtHsHtzJT1kRqYmnqWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 3:19 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Nov 12, 2013 at 7:47 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> +       .handle_irq     = sa1100_handle_irq,
>
> In interest of shrinking the machine_desc, can you set the handler in
> sa1100_init_irq instead? That is how the gic and vic initialization
> work now. sa1100_handle_irq can also then become static.

It seems like Dmitry (E-S) will be running a MULTI_IRQ_HANDLER
series rather than me since he has a stack of patches, so
I'll refer to him for now, Dmitry take notice!

Yours,
Linus Walleij
