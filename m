From: treding@nvidia.com (Thierry Reding)
Date: Wed, 19 Nov 2014 15:20:10 +0100
Subject: arm64 pci_iomap, was: Re: next build: 258 warnings 9 failures
 (next/next-20141119)
In-Reply-To: <3897871.0i8K9av6A3@wuerfel>
References: <546c75d7.6336460a.14b5.474d@mx.google.com>
 <16479190.7SIDaKWfdW@wuerfel>
 <20141119135641.GD26258@ulmo.nvidia.com>
 <3897871.0i8K9av6A3@wuerfel>
Message-ID: <20141119142009.GA3488@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 03:11:03PM +0100, Arnd Bergmann wrote:
> On Wednesday 19 November 2014 14:56:42 Thierry Reding wrote:
> > 
> > Oops, I just looked at that file on my system and I already have the
> > select GENERIC_PCI_IOMAP exactly where you have it. Turns out I have
> > that same patch, albeit with a somewhat obfuscated name in my tree
> > but never got around to clean up the commit message or sending it out.
> > 
> > Do you want to apply that patch on top or shall I redo the pull request
> > with that patch folded in so we can keep bisectability across the
> > series?
> 
> I would prefer to have my patch applied on top so I don't have to redo
> the merge between your patches and Will's patches.

Okay.

> Can you confirm that you have no further patches that I might need?

Yes, I have no other patches asm-generic related patches.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/422f7251/attachment.sig>
