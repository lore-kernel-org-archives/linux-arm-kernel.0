From: bhupesh.sharma@freescale.com (Sharma Bhupesh)
Date: Thu, 15 Oct 2015 20:01:53 +0000
Subject: [PATCH v3 09/12] dts/ls2080a: Update Simulator DTS to add support
 of various peripherals
In-Reply-To: <6141791.soHsjI1RN1@wuerfel>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
 <1444891672-32117-10-git-send-email-bhupesh.sharma@freescale.com>
 <6141791.soHsjI1RN1@wuerfel>
Message-ID: <BY1PR0301MB130398142AA4A4DAEDB08CBB823E0@BY1PR0301MB1303.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Thursday, October 15, 2015 7:49 PM
> 
> On Thursday 15 October 2015 12:17:49 Bhupesh Sharma wrote:
> > +
> > +&esdhc {
> > +       status = "disabled";
> > +};
> > +
> > +&ifc {
> > +       status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +       status = "disabled";
> > +};
> > +
> > +&i2c1 {
> > +       status = "disabled";
> > +};
> > +
> > +&i2c2 {
> > +       status = "disabled";
> > +};
> 
> The more common way to do this is to turn off all optional HW blocks in
> the .dtsi file and then overide the ones that are connected on a
> particular board by overriding the status to "ok" there.

I kind of remember it the other way around. But this will not be a huge change,
so will address it in v4.

Regards,
Bhupesh
