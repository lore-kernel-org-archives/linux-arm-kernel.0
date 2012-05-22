From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 09:51:03 +0800
Subject: [PATCH v2 00/12] add imx usb driver for mx28/6x
In-Reply-To: <F281D0F91ED19E4D8E63A7504E8A649803BB2B79@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <201205212141.52171.marex@denx.de> <4FBA9BE4.7020303@grid-net.com>
 <201205212207.34978.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803BB2B2F@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120522014158.GF6206@b20223-02.ap.freescale.net>
 <F281D0F91ED19E4D8E63A7504E8A649803BB2B79@039-SN2MPN1-023.039d.mgd.msft.net>
Message-ID: <20120522015102.GG6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 09:44:14AM +0800, Chen Peter-B29397 wrote:
>  
> > > >
> > > > This here is definitelly going to support mx28 and I'm slowly working
> > > > through
> > > > the DT stuff to test this, all right?
> > > >
> > > > We were talking about imx.{xz|x,y is [0-9a-z]} \ imx.{23,28,6q}
> > > >
> > > This driver needs to work on both DT and non-DT support.
> > > Let's do it after next version when we need to add it for old mxc
> > platform.
> > I don't think so. We only need to go right direction and don't do
> > extra work for what is going to be abandoned.
> Are you sure all i.mx platform will support DT in future?
Finally, yes.
> 
> > 
> > Thanks
> > Richard
> > >
> > >
> > > > >
> > > > > -Subodh
> > > >
> > > > Best regards,
> > > > Marek Vasut
> > >
