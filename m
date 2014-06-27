From: horms@verge.net.au (Simon Horman)
Date: Sat, 28 Jun 2014 08:56:56 +0900
Subject: [PATCH v5 0/2] Add R8A7790/Lager board PCI USB DT support
In-Reply-To: <20140627235622.GA29865@verge.net.au>
References: <201406242157.05973.sergei.shtylyov@cogentembedded.com>
 <20140627235622.GA29865@verge.net.au>
Message-ID: <20140627235656.GB29865@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 08:56:22AM +0900, Simon Horman wrote:
> On Tue, Jun 24, 2014 at 09:57:04PM +0400, Sergei Shtylyov wrote:
> > Hello.
> > 
> >    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
> > 'renesas-devel-v3.16-rc2-20140623' tag. Here we add PCI USB device tree support
> > for the R8A7790-based Lager board. As the 'pci-rcar-gen2' driver device tree
> > support has been merged for 3.16, this patchset can now be merged too...
> > 
> > [1/2] ARM: shmobile: r8a7790: add internal PCI bridge nodes
> > [2/2] ARM: shmobile: lager: enable internal PCI
> 
> Thanks, I will queue these up with
> Shimoda-san's Tested-by.

And Arnd's Ack
