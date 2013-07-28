From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 27 Jul 2013 22:39:25 -0600
Subject: DT bindings as ABI [was: Do we have people interested in device
 tree janitoring / cleanup?]
In-Reply-To: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
Message-ID: <20130728043925.8F3BE3E08FE@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jul 2013 09:09:19 -0700, Olof Johansson <olof@lixom.net> wrote:
> [I'm adding LKML and ksummit-discuss to this thread, since the ACPI/DT
> discussions have been covered there and this overlaps some with that]
> 
> On Thu, Jul 25, 2013 at 7:38 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Jul 25, 2013 at 03:27:02PM +0100, Russell King - ARM Linux wrote:
> >> Remember the stated assertion when DT was first added to the kernel: the
> >> DT descriptions _will_ become a separately maintained project which is
> >> independent of the kernel.  They will _not_ be kernel version specific.
> >
> > I'm looking forward to this.
> >
> > Question for the DT guys: what are the plans here? Are we going to get
> > rid of the .dts files inside the kernel tree?
> 
> In the discussions we had in Dublin, a couple of options on how to
> lock in bindings were discussed. I'm a little surprised that Grant
> didn't cover them in his initial emails on the new maintainership
> model, but maybe he wanted the new group to handle it. And they didn't
> bring it up yet either. So I am. :-)

Excellent! My plan to avoid responsibility for stuff is proceeding.
Actually, I think I touched on it, but the details got lost in my head
among all the other stuff we discussed two weeks ago. Thanks for getting
this detail down into an email.

g.
