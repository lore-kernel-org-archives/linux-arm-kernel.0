From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Aug 2012 22:28:40 +0200
Subject: [PATCH] ARM: ux500: set proper GIC flags
In-Reply-To: <CAMQu2gx9kU4sPL5-TsJTq_2pUvm3Jm6rNWS=XYQJihTUpm1nHg@mail.gmail.com>
References: <1345813264-4896-1-git-send-email-linus.walleij@stericsson.com>
 <CAMQu2gx9kU4sPL5-TsJTq_2pUvm3Jm6rNWS=XYQJihTUpm1nHg@mail.gmail.com>
Message-ID: <CACRpkdZS1-XMR2JJsu77SHigb4PENo0UXFxp_i8pUrb6AWHqJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 3:08 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
>> +       gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
>> +
> With this patch, you should no longer need the dummy set_irq_wake()
> patch which I was form
> you for ux500.

Yep, it's somehow gone already (though it was preserved on the
internal kernel...)

Yours,
Linus Walleij
