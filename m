From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Jul 2013 13:33:30 -0400
Subject: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <51E4167B.4000208@wwwdotorg.org>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org>
Message-ID: <20130715173329.GA12062@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 09:34:19AM -0600, Stephen Warren wrote:
> On 07/15/2013 05:52 AM, Thomas Petazzoni wrote:
> > Hello,
> > 
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> > 
> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. This set of patches applies on top
> > of 3.11-rc1.
> 
> Thomas, who is going to merge this series?

In a previous version of this series, Thomas and I discussed the
feasibility of sending the irq changes through tglx, the pci changes
through Bjorn, and the mvebu stuff through us.  With that version,
Thomas felt it would work out fine, without depending on each other.

If this is still the case, we'll just ask Thomas and Bjorn (or, at least
Bjorn) to make topic branches for us.

thx,

Jason.
