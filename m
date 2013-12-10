From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Dec 2013 19:43:03 +0000
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131210191730.GT5429@obsidianresearch.com>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233654.GV16735@n2100.arm.linux.org.uk>
 <20131210191730.GT5429@obsidianresearch.com>
Message-ID: <20131210194303.GB4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 12:17:30PM -0700, Jason Gunthorpe wrote:
> On Mon, Nov 25, 2013 at 11:36:54PM +0000, Russell King - ARM Linux wrote:
>  
> > Actually, I think Nicolas' commit:
> > 
> > 1b9f95f8ade9efc2bd49f0e7b9dc61a038ac3eef
> > 
> > was wrong to remove PLAT_PHYS_OFFSET.  So, partially undoing Nicolas'
> > patch, and reordering things a little, we end up with this, which if
> > it weren't for the comment would be 5 lines shorter!
> 
> Not sure where this thread ended up, but:

Nowhere because there was no evidence of the patch being tested.

> Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Now committed, thanks.
