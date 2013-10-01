From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 13:28:29 -0400
Subject: [PATCH v2] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture
 properties
In-Reply-To: <20131001172259.GA19668@obsidianresearch.com>
References: <20130917201104.GA5209@obsidianresearch.com>
 <20131001164409.GC31178@titan.lakedaemon.net>
 <20131001165045.GB23874@obsidianresearch.com>
 <20131001170918.GF31178@titan.lakedaemon.net>
 <20131001172259.GA19668@obsidianresearch.com>
Message-ID: <20131001172829.GG31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 11:22:59AM -0600, Jason Gunthorpe wrote:
> On Tue, Oct 01, 2013 at 01:09:18PM -0400, Jason Cooper wrote:
...
> > > This patch is a necessary precondition to applying:
> > > 
> > > https://github.com/jgunthorpe/linux/commit/ef90b0bf7d8552dc7dfaad82d964446f6a9b6a3b
> > > PCI: mvebu - Support a bridge with no IO port window
> > 
> > I don't see this one in my stack, have you submitted it yet?  When you
> > do, please add a note mentioning the dependency on this commit in
> > mvebu/fixes.
> 
> Yes, I posted it along with the other PCI patches:
> 
> http://permalink.gmane.org/gmane.linux.kernel.pci/25498
> 
> Just so we are on the same page, these are the Kirkwood/mvebu patches
> I was hoping to progress for 3.13:
> 
> https://github.com/jgunthorpe/linux/commit/9f20eec4696627afe87bf0f6a204909004062e8e
> PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug
> (Thomas soft ack'd this @ http://www.spinics.net/lists/linux-pci/msg25323.html)
> 
> https://github.com/jgunthorpe/linux/commit/ef90b0bf7d8552dc7dfaad82d964446f6a9b6a3b
> PCI: mvebu - Support a bridge with no IO port window
> (no comments)

Could you resend the above patches to me?

thx,

Jason.
