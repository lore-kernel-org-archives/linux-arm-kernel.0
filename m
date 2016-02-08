From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 8 Feb 2016 15:04:29 +0100
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <56B86391.1030609@arm.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
 <56B86391.1030609@arm.com>
Message-ID: <20160208140429.GF4117@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Feb 08, 2016 at 09:44:49AM +0000, Marc Zyngier wrote:
> On 08/02/16 09:16, Antoine Tenart wrote:
> > +
> > +static struct msi_domain_info alpine_msix_domain_info = {
> > +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > +		  MSI_FLAG_PCI_MSIX,
> 
> You can probably add MSI_FLAG_PCI_MSI

Are you sure such a flag is available? (Or am I missing something
obvious?).

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/18f7073a/attachment.sig>
