From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 3 Jan 2013 17:01:06 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <201301031556.31618.arnd@arndb.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
 <201301031556.31618.arnd@arndb.de>
Message-ID: <20130103160106.GA7086@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 03:56:31PM +0000, Arnd Bergmann wrote:
> On Thursday 03 January 2013, Thierry Reding wrote:
> > Stephen proposed drivers/pci/host on IRC and I second that.
> 
> Agreed, I like that, too. There is a little problem with cross-platform
> PCI hosts still because some portion of the interface is still arch
> specific, but I don't see this as a show-stopper for moving drivers
> there. The ARM specific drivers can still use the ARM interfaces
> for now, until everything is made generic. If they are going to
> be shared with other architectures, those can use the same interfaces
> that ARM has. I think Microblaze, ARC and Metag are strong candidates
> for doing this.

Great, sounds like a plan. I'll move Tegra PCIe into drivers/pci/host
then.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130103/bf0e6ef1/attachment.sig>
