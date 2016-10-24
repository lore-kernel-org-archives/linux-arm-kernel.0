From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Oct 2016 09:41:07 +0100
Subject: mbox-name vs. mbox-names (was: Re: [PATCH v4 1/5] mailbox: dt:
 Supply bindings for ST's Mailbox IP)
In-Reply-To: <CAMuHMdXqOZ=eKJ=SkY4TM=fu8qnZ2gLmh-2iH0jB2pAu_v2vNg@mail.gmail.com>
References: <CAMuHMdXqOZ=eKJ=SkY4TM=fu8qnZ2gLmh-2iH0jB2pAu_v2vNg@mail.gmail.com>
Message-ID: <20161024084107.GD14477@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016, Geert Uytterhoeven wrote:

> On Fri, Oct 16, 2015 at 9:21 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  .../devicetree/bindings/mailbox/sti-mailbox.txt    | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> > new file mode 100644
> > index 0000000..b61eec9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> > @@ -0,0 +1,51 @@
> > +ST Microelectronics Mailbox Driver
> > +
> > +Each ST Mailbox IP currently consists of 4 instances of 32 channels.  Messages
> > +are passed between Application and Remote processors using shared memory.
> > +
> > +Controller
> > +----------
> > +
> > +Required properties:
> > +- compatible           : Should be "st,stih407-mailbox"
> > +- reg                  : Offset and length of the device's register set
> > +- mbox-name            : Name of the mailbox
> 
> All other mailbox drivers use "mbox-names". Oops, it's in v4.9-rc1...
> 
> Can we still fix that?

So long as all the fixes; changes to the driver and DT are merged in a
single kernel release, we can change it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
