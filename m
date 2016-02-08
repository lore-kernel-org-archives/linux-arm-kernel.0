From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 8 Feb 2016 16:05:01 +0100
Subject: [PATCH 2/6] Documentation: bindings: document the Alpine MSIX
 driver
In-Reply-To: <56B8AC7D.8060102@arm.com>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-3-git-send-email-antoine.tenart@free-electrons.com>
 <56B8AC7D.8060102@arm.com>
Message-ID: <20160208150501.GA19758@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 02:55:57PM +0000, Marc Zyngier wrote:
> On 08/02/16 09:16, Antoine Tenart wrote:
> > +
> > +Example:
> > +
> > +msix: msix {
> > +	compatible = "al,alpine-msix";
> > +	reg = <0x0 0xfbe00000 0x0 0x100000>;
> > +	interrupt-controller;
> > +	msi-controller;
> > +	al,msi-base-spi = <160>;
> > +	al,msi-num-spis = <160>;
> > +};
> > 
> 
> This example seems to rely on an implicit interrupt-parent. You probably
> want to update the example to clarify it.

Right. I'll add the interrupt-parent property in the required properties
and in the example msix node.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/ff723db7/attachment.sig>
