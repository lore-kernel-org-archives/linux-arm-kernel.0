From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 11 Mar 2014 12:45:13 -0600
Subject: [linux-sunxi] Re: [RFC PATCH v2 08/14] mtd: nand: add sunxi NAND
 flash controller support
In-Reply-To: <531D9F4B.6040505@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-9-git-send-email-b.brezillon.dev@gmail.com>
 <20140129175641.GF1427@obsidianresearch.com>
 <20140129184619.GC27143@localhost>
 <20140129191005.GG1427@obsidianresearch.com>
 <531D9F4B.6040505@gmail.com>
Message-ID: <20140311184513.GC31835@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 12:17:31PM +0100, Boris BREZILLON wrote:
> Hello Jason,
> 
> Le 29/01/2014 20:10, Jason Gunthorpe a ?crit :
> >On Wed, Jan 29, 2014 at 03:46:20PM -0300, Ezequiel Garcia wrote:
> >
> >>After CE# has been pulled high and then transitioned low again, the host
> >>should issue a Set Features to select the appropriate asynchronous timing mode.
> >>"""
> >Oh, I had forgot you should do a set feature too
> >
> >Boris, I think the core core should handle this dance and the driver
> >should just implement a call back to change the timing mode on the
> >interface..
> >
> >If I ever get a moment I can work on support for timing setting in the
> >mvebu driver, I have boards here with ONFI NAND..
> 
> Any progress on this ?
> I'm about to post the 3rd version of this series and if you already have
> something working I could base my work on your proposal.

Sorry, no, I will try to look over your v3 though.

Regards,
Jason
