From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Oct 2013 16:40:06 -0600
Subject: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link is
 up to enable hot plug
In-Reply-To: <CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <CAErSpo6pvAQ9exEUsB0p8nmoqs0s5yzfYsstx7wh-2bqDtzBOQ@mail.gmail.com>
Message-ID: <20131007224006.GA27499@obsidianresearch.com>
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
> least for the v3.13 merge window.  But you marked this "resend"; does
> that mean you're waiting for me to do something with it?

Are you thinking of Jason C.? He is handling much of the mvebu stuff.

Hopefully Jason C. can clarify which route these patches should take
to hit the 3.13 merge window.

This was reposted at the request of Thomas, IIRC.

>   PCI: mvebu - Support a bridge with no IO port window

This one is broken, I have yet to fix it still.

>   PCI: mvebu: add I/O access wrappers

This isn't one of mine ..

Regards,
Jason
