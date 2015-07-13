From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 13 Jul 2015 12:06:13 +0200
Subject: [PATCH 00/15] ARM: shmobile: Remove legacy sh73a0/kzm9g and
 r8a7740/armadillo
In-Reply-To: <CACRpkdZFPCo8x0p6MnG-m4DVHBefRDj4PLC8zi3tj1zgUkT2fA@mail.gmail.com>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
 <20150619034052.GA22912@verge.net.au>
 <CAMuHMdUqO2_rMpx0akeS1j+pNmQ_S150ei0B6a1ubFu_iTBF3g@mail.gmail.com>
 <CACRpkdZFPCo8x0p6MnG-m4DVHBefRDj4PLC8zi3tj1zgUkT2fA@mail.gmail.com>
Message-ID: <CAMuHMdUcY56tWbD6r6mxLF_a1bpy0q7URY1qJGRvsxxvTx5gnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Jul 13, 2015 at 12:00 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, Jun 19, 2015 at 9:30 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Jun 19, 2015 at 5:41 AM, Simon Horman <horms@verge.net.au> wrote:
>>> [ CC Linus, Laurent, linux-gpio ]
>
>>>>   pinctrl: sh-pfc: sh73a0: Remove obsolete multi-platform check
>>>>   pinctrl: sh-pfc: Remove obsolete sh73a0 platform_device_id entry
>>>>   pinctrl: sh-pfc: r8a7740: Remove obsolete multi-platform check
>>>>   pinctrl: sh-pfc: Remove obsolete r8a7740 platform_device_id entry
>>>
>>> As the above patches are sh-pfc patches they would typically
>>> be steered through Linus's tree via Laurent. If they wish
>>> to take that path then I'm happy for this to be attached:
>>>
>>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>>
>>> FWIW the above path is the one that the removal of mackerel/sh7372 took.
>>>
>>> Alternatively, I am happy to take the above sh-pfc patches through
>>> my tree but I would like to do so with an Ack from at least Linus.
>>
>> I didn't CC Linus and linux-gpio at this stage yet, to prevent the pfc
>> patches from getting applied prematurely.
>> But things have gone more smoothly (esp. w.r.t. board staging) than expected,
>> which is always pleasant.
>
> I would prefer to take these four into the pin control tree when you
> consider them finished as there is obviously more PFC stuff coming
> for this next kernel cycle and I want to avoid collisions and keep
> things together. Will you send them to me separately?

OK, I will send them your way.

I think at this point we're quite sure the sh73a0/r8a7740 removal will hit v4.3.
This does mean sh73a0/r8a7740-legacy will be broken in pinctrl/for-next,
but we don't care, as the support is gone in -next anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
