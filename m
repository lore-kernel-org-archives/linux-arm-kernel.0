From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 2 Jan 2013 13:09:32 -0700
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <20121229093359.GA5877@avionic-0098.adnet.avionic-design.de>
References: <20121217194147.GA2767@avionic-0098.adnet.avionic-design.de>
 <50CFD0B3.6030208@wwwdotorg.org>
 <20121218025113.GA27029@obsidianresearch.com>
 <50D0A1EA.9090009@wwwdotorg.org>
 <20121220153231.GA11256@avionic-0098.adnet.avionic-design.de>
 <20121222155040.61829b00@skate>
 <20121228210622.GA4519@avionic-0098.adnet.avionic-design.de>
 <20121228221632.3892e90b@skate> <50DE2FFB.8040804@wwwdotorg.org>
 <20121229093359.GA5877@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130102200932.GA2956@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 29, 2012 at 10:33:59AM +0100, Thierry Reding wrote:

> It isn't actually required to make PCI work, but it enables PCI device
> matching to DT nodes with the generic code. If we leave out the host
> bridge, then the matching becomes rather complicated and we'll most

Can you elaborate on this a bit? What do pci bus location bindings look
like?

BTW, does anyone have working links for the various PDFs (ePAR, PCI
bindings, etc) for open firmware stuff, they all seem broken these
days..

Cheers,
Jason
