From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 07:57:27 -0400
Subject: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link
 is up to enable hot plug
In-Reply-To: <CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com>
Message-ID: <20131008115727.GD5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 04:28:52PM -0600, Bjorn Helgaas wrote:
> [+cc Seungwon]
> 
> On Tue, Oct 1, 2013 at 11:58 AM, Jason Gunthorpe
> <jgunthorpe@obsidianresearch.com> wrote:
> > Otherwise hotplugging the PEX doesn't work at all since the driver
> > detects the link state at probe time. Simply replacing the two tests
> > of haslink with a register read is enough to fix it.
> >
> > Tested on kirkwood with repeated plug/unplug of the link partner.
> >
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> 
> Last I heard (Sep 26), you had some mvebu changes in your tree
> already, Jason, so I was assuming you'd handle pci-mvebu.c changes, at
> least for the v3.13 merge window.  But you marked this "resend"; 

That's correct.  I somehow missed these two and I asked JasonG to resend
them to me.

> does that mean you're waiting for me to do something with it?

Nope, It means I'm looking for a slice of time to get caught up :-P

> I see the following mvebu patches in patchwork:
> 
>   PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug
>   PCI: mvebu - Support a bridge with no IO port window
>   PCI: mvebu: add I/O access wrappers
> 
> Let me know if I need to do anything with any of them.

I always appreciate an extra set of eyes ;-)  Hopefully, after v3.13, we
can get back to normal wrt patches going through proper trees.

thx,

Jason.
