From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 21 May 2014 11:37:17 -0400
Subject: [PATCH 03/10] irqchip: versatile-fpga: add pass-thru enable
 support
In-Reply-To: <CAL_JsqJHernZ08vF6_a=Vz41dm1aAo7vZcK+G3pvVYhB7ytP9Q@mail.gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-4-git-send-email-robherring2@gmail.com>
 <20140521014146.GG8664@titan.lakedaemon.net>
 <CAL_JsqJHernZ08vF6_a=Vz41dm1aAo7vZcK+G3pvVYhB7ytP9Q@mail.gmail.com>
Message-ID: <20140521153717.GI8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 10:35:38AM -0500, Rob Herring wrote:
> On Tue, May 20, 2014 at 8:41 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > Rob,
> >
> > On Tue, May 20, 2014 at 04:09:29PM -0500, Rob Herring wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> Set the PIC_ENABLES register when the passthru-mask property is present.
> >> This enables interrupts on the secondary controller to be passed thru
> >> directly to the primary controller.
> >>
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> Cc: Thomas Gleixner <tglx@linutronix.de>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> ---
> >>  drivers/irqchip/irq-versatile-fpga.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >
> > Patches 3 and 4 are good to go.  Shall I take them, or are they a
> > depended on by later patches?
> 
> Thanks. There are dependencies, so I plan to send it all thru arm-soc.

Very well.  For both:

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
