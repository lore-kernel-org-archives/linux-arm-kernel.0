From: Dongsheng.Wang@freescale.com (Wang Dongsheng)
Date: Fri, 25 Sep 2015 02:51:36 +0000
Subject: [PATCH v3 1/2] fsl: Add binding for RCPM
In-Reply-To: <1443149032.32298.102.camel@freescale.com>
References: <1443083354-37369-1-git-send-email-dongsheng.wang@freescale.com>
 <1443123009.32298.29.camel@freescale.com>
 <SN1PR0301MB161653CC69BB78A0A8B565569D420@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <1443149032.32298.102.camel@freescale.com>
Message-ID: <SN1PR0301MB16165FD739C5CD90FB4352149D420@SN1PR0301MB1616.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, 2015-09-24 at 21:38 -0500, Wang Dongsheng-B40534 wrote:
> > > > +* Freescale RCPM Wakeup Source Device Tree Bindings
> > > > +-------------------------------------------
> > > > +Required rcpm-wakeup property should be added to a device node if the
> > > > device
> > > > +can be used as a wakeup source.
> > > > +
> > > > +  - rcpm-wakeup: The value of the property consists of cells, the
> > > > number of
> > > > +     cells defined in "fsl,#rcpm-wakeup-cells". The first cell is a
> > > > pointer
> > > > +     to the rcpm node, the second cell is the bit mask that should be
> > > > set
> > > > +     in IPPDEXPCR0, and the third cell is for IPPDEXPCR1, and so on.
> > >
> > > The phandle should not be included in the cell count.
> > >
> >
> > Yes, the first cell "&rcpm" should be in the cell count, right?
> 
> No.  None of the other #foo-cells work that way.
> 

Sorry a type wrong. I means the first cell "&rcpm" should *NOT* be in the cell count.

Regards,
-Dongsheng
