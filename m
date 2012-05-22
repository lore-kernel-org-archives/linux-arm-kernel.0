From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 22 May 2012 01:44:14 +0000
Subject: [PATCH v2 00/12] add imx usb driver for mx28/6x
In-Reply-To: <20120522014158.GF6206@b20223-02.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205212141.52171.marex@denx.de> <4FBA9BE4.7020303@grid-net.com>
 <201205212207.34978.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803BB2B2F@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120522014158.GF6206@b20223-02.ap.freescale.net>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BB2B79@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > >
> > > This here is definitelly going to support mx28 and I'm slowly working
> > > through
> > > the DT stuff to test this, all right?
> > >
> > > We were talking about imx.{xz|x,y is [0-9a-z]} \ imx.{23,28,6q}
> > >
> > This driver needs to work on both DT and non-DT support.
> > Let's do it after next version when we need to add it for old mxc
> platform.
> I don't think so. We only need to go right direction and don't do
> extra work for what is going to be abandoned.
Are you sure all i.mx platform will support DT in future?

> 
> Thanks
> Richard
> >
> >
> > > >
> > > > -Subodh
> > >
> > > Best regards,
> > > Marek Vasut
> >
