From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 24 Mar 2017 10:38:05 -0500
Subject: [PATCH 2/4 v5] PCI: add driver for Faraday Technology Host Bridge
In-Reply-To: <CACRpkdbkhui0iwJbOeD8uwurdWvOYdPKtRPQhSkg0atpAB174Q@mail.gmail.com>
References: <20170312222403.2473-1-linus.walleij@linaro.org>
 <20170324150753.GC25380@bhelgaas-glaptop.roam.corp.google.com>
 <CACRpkdbkhui0iwJbOeD8uwurdWvOYdPKtRPQhSkg0atpAB174Q@mail.gmail.com>
Message-ID: <20170324153805.GA31729@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 04:14:43PM +0100, Linus Walleij wrote:
> On Fri, Mar 24, 2017 at 4:07 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Thanks!
> 
> > I don't know enough to review the DT patch, but you have Rob's ack
> > already.
> >
> > Not sure how you want to merge these; if you want to feed the whole
> > thing via ARM SoC, that's fine with me.  Otherwise, let me know if
> > you'd like me to take anything.
> 
> It'd be perfect if you could merge patches 1+2 into the PCI tree,
> there are no dependencies to the ARM tree.
> 
> > Noticed one trivial typo below.
> >
> >> + * Special configuration registers directly in the first few words
> >> + * in he I/O space.
> >
> > s/he//
> 
> Can you fix it when applying or do you want me to resend it with
> this fixed?

I fixed it.

Applied 1 & 2 to pci/host-faraday for v4.12, thanks!
