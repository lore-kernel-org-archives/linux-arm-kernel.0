From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 22 Feb 2014 06:53:23 +1100
Subject: pci-mvebu driver on km_kirkwood
In-Reply-To: <CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
References: <20130711163220.2b3adf38@skate> <53039894.10905@keymile.com>
 <20140218212751.07c2aeb5@skate> <53046D98.6020801@keymile.com>
 <20140219102658.76eec91e@skate> <53047BBB.6040108@keymile.com>
 <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate>
 <CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
 <20140221002438.GE19893@obsidianresearch.com>
 <CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
Message-ID: <1393012403.6771.89.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-21 at 12:05 -0700, Bjorn Helgaas wrote:
> But I wonder if powerpc has a similar issue here: I think EEH might
> need, for example 16MB bridge window alignment.  Since
> pcibios_window_alignment() only affects the *starting* address, could
> the core assign a 9MB window whose starting address is 16MB-aligned?
> Could EEH deal with that?  What if the PCI core assigned the space
> right after the 9MB window to another device?

Gavin, did you guys deal with that at all ? Are we aligning the size as
well somewhat ?

Cheers,
Ben.
