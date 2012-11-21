From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 21 Nov 2012 10:33:57 -0700
Subject: [PATCH] ARM: Kirkwood: Update PCI-E fixup
In-Reply-To: <20121121160555.0710e048@skate>
References: <20121121071906.GF19837@obsidianresearch.com>
 <20121121160555.0710e048@skate>
Message-ID: <20121121173357.GC6406@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 04:05:55PM +0100, Thomas Petazzoni wrote:
> Dear Jason Gunthorpe,
> 
> On Wed, 21 Nov 2012 00:19:06 -0700, Jason Gunthorpe wrote:
> 
> > +/* The root complex has a hardwired class of PCI_CLASS_MEMORY_OTHER, when it
> > +   is operating as a root complex this needs to be switched to
> > +   PCI_CLASS_BRIDGE_HOST or Linux will errantly try to process the BAR's on
> > +   the device. Decoding setup is handled by the orion code. */
> 
> Sorry for this unique silly review comment, but this comment does not
> comply with the kernel CodingStyle for multicomments. It should be:

Ok! Though I'm surprised checkpatch didn't complain?

Jason
