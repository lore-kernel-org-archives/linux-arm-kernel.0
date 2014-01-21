From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 21 Jan 2014 17:13:13 +0000
Subject: [PATCH 1/4 v3] mfd: tc3589x: Add device tree bindings
In-Reply-To: <CACRpkdZoEwgRALT0R8vWB1aWxR_WCR2U0b1yF0Mr0qNm0LDGug@mail.gmail.com>
References: <1384265558-10521-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZoEwgRALT0R8vWB1aWxR_WCR2U0b1yF0Mr0qNm0LDGug@mail.gmail.com>
Message-ID: <20140121171313.GC27111@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This defines the device tree bindings for the Toshiba TC3589x
> > series of multi-purpose expanders. Only the stuff I can test
> > is defined: GPIO and keypad. Others may implement more
> > subdevices further down the road.
> >
> > This is to complement
> > commit a435ae1d51e2f18414f2a87219fdbe068231e692
> > "mfd: Enable the tc3589x for Device Tree" which left off
> > the definition of the device tree bindings.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v2->v3:
> > - Fix the keys/rows bindings to be u32 rather than
> >   /bits/ 8, inconsistency noted by Mark Rutland.
> > ChangeLog v1->v2:
> > - Include a verbose example in the DT bindings.
> > - Explain why this is a stand-alone bindings patch.
> 
> So will this since Nov 12 uncommented-upon patch be merged or
> do you want me to do some change?
> 
> There was some back-and-forth regarding the (existing, already
> in use) linux-specific input bindings but the only thing I can
> see is some back and forth leaning toward just letting these
> be used.

We still need a DT Ack.

> I am happy to change this in whatever way but no directions
> for two months....

If it had slipped though the gaps, I'd probably suggest poking or
re-sending before the middle of the merge-window though.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
