From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 6 Feb 2013 20:35:21 +0100
Subject: [PATCH 06/14] ARM: pci: Keep pci_common_init() around after init
In-Reply-To: <20130206163041.GG17833@n2100.arm.linux.org.uk>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-7-git-send-email-thierry.reding@avionic-design.de>
 <20130205204147.GA29726@avionic-0098.mockup.avionic-design.de>
 <20130206163041.GG17833@n2100.arm.linux.org.uk>
Message-ID: <20130206193521.GA455@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 04:30:41PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 05, 2013 at 09:41:48PM +0100, Thierry Reding wrote:
> > On Wed, Jan 09, 2013 at 09:43:06PM +0100, Thierry Reding wrote:
> > > When using deferred driver probing, PCI host controller drivers may
> > > actually require this function after the init stage.
> > > 
> > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > > ---
> > >  arch/arm/kernel/bios32.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > Russell,
> > 
> > Can this patch and patch 7 (ARM: pci: Allow passing per-controller
> > private data) of this series be applied for 3.9? Thomas uses them in his
> > Marvell PCIe series as well and it would allow to reduce the complexity
> > of the dependencies.
> 
> It'll need to go into the patch system in that case...

Alright, I'll submit them to the patch system. Thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130206/820a32aa/attachment.sig>
