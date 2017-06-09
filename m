From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 9 Jun 2017 08:40:19 +0200
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <20170608160331.GA20216@lunn.ch>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
 <20170608160331.GA20216@lunn.ch>
Message-ID: <20170609064019.GB31464@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Jun 08, 2017 at 06:03:31PM +0200, Andrew Lunn wrote:
> On Thu, Jun 08, 2017 at 11:26:52AM +0200, Antoine Tenart wrote:
> > +#define MVMDIO_XSMI_MGNT_REG		0x0
> > +#define  MVMDIO_XSMI_READ_VALID		BIT(29)
> > +#define  MVMDIO_XSMI_BUSY		BIT(30)
> > +#define MVMDIO_XSMI_ADDR_REG		0x8
> > +#define  MVMDIO_XSMI_PHYADDR_SHIFT	16
> > +#define  MVMDIO_XSMI_DEVADDR_SHIFT	21
> > +#define  MVMDIO_XSMI_READ_OPERATION	(0x7 << 26)
> > +#define  MVMDIO_XSMI_WRITE_OPERATION	(0x5 << 27)
> 
> These two operations seem odd. Generally ops have the same shift.

Indeed, this is odd. I'll have a look at this.

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/d6fc7877/attachment.sig>
