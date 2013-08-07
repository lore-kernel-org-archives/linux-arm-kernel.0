From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 7 Aug 2013 08:59:56 +0200
Subject: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130806200256.GB19280@titan.lakedaemon.net>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130806200256.GB19280@titan.lakedaemon.net>
Message-ID: <20130807065954.GA22906@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 04:02:56PM -0400, Jason Cooper wrote:
> Thomas,
> 
> In order to get some testing in -next, I've *tentatively* applied this
> series in the following way:
> 
> +---+ mvebu/msi_common (1,2,3,10)
>     |
>     +---+---+ mvebu/msi_irq (4-9)
>             |
>             +---+---+ mvebu/msi_mvebu (11-13)
> 
> I had to make one change to patch #9, I protected the last two blocks
> with #ifdef CONFIG_PCI_MSI to prevent a build failure at that point.
> 
> mvebu/msi_common should be appropriate for Thierry to base off, however,
> I make no guarantees about the stability of the branch until I send a
> PR for it.  Code-wise, it should be fine, but the commit-ids may change
> due to adding Tested-by's, etc.

I noticed that patch 10 has my Reviewed-by, even though my comments
weren't addressed. They were about stylistic issues but I'd still like
to see them fixed now rather than having to fix them up later. Also I
think I gave my Tested-by on those patches somewhere already and I think
it's unlikely that anybody else will test them, so with the consistency
style fixes applied I don't see any reason why that branch can't be
stabilized right away.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/10c41cd0/attachment.sig>
