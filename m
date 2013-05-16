From: tony@atomide.com (Tony Lindgren)
Date: Thu, 16 May 2013 08:23:41 -0700
Subject: [PATCH] ARM: omap2: remove CONFIG_ARCH_OMAP2PLUS_TYPICAL
In-Reply-To: <CAL_JsqJgc39YO3-L=-kgJ=wmXhe-dAP5nHngaCLbxfheAEvduA@mail.gmail.com>
References: <1368710950-2306-1-git-send-email-robherring2@gmail.com>
 <20130516151126.GP5600@atomide.com>
 <CAL_JsqJgc39YO3-L=-kgJ=wmXhe-dAP5nHngaCLbxfheAEvduA@mail.gmail.com>
Message-ID: <20130516152338.GQ5600@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robherring2@gmail.com> [130516 08:25]:
> On Thu, May 16, 2013 at 10:11 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Rob Herring <robherring2@gmail.com> [130516 06:34]:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> CONFIG_ARCH_OMAP2PLUS_TYPICAL is selecting user defined features, not h/w
> >> required options. This does not play well with multi-platform kernels and
> >> belongs in a defconfig.
> >
> > Yes we can remove this. But let's update omap2plus_defconfig with these
> > options where needed. I can update this patch for that and queue it
> > if that works for you.
> >
> 
> Yes, that's fine. You might also want to enable the h/w related
> features to multi_v7_defconfig as well.

Yes will do. BTW, getting rid of CONFIG_ARCH_OMAP2PLUS_TYPICAL was the
reason I did not update multi_v7_defconfig yet.

I'll also update Arnd's randconfig fix patch and post it, then
will stick all three patches into one branch.

Regards,

Tony
