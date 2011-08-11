From: balbi@ti.com (Felipe Balbi)
Date: Thu, 11 Aug 2011 21:55:59 +0300
Subject: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
In-Reply-To: <20110811185408.GB15970@legolas.emea.dhcp.ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
	<1312979122-5896-7-git-send-email-j-keerthy@ti.com>
	<20110810124629.GJ12882@legolas.emea.dhcp.ti.com>
	<CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com>
	<20110811103658.GG27742@legolas.emea.dhcp.ti.com>
	<CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com>
	<20110811141248.GK28500@legolas.emea.dhcp.ti.com>
	<CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com>
	<20110811185408.GB15970@legolas.emea.dhcp.ti.com>
Message-ID: <20110811185558.GC15970@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 11, 2011 at 09:54:09PM +0300, Felipe Balbi wrote:
> > > you need some other way to handle this. Why do you need to manually set
> > > the rate rather than having hwmod handle this for you ?
> > >
> > > your argument that "it's a one time setting" is not enough to have this
> > > in the driver. Drivers should not care about clocks anymore, this should
> > > have been done on another layer.
> > 
> > Hwmod will have no idea on the rate required.
> 
> does the rate need to change ? Also, I have not mentioned hwmod anytime

i did mention hwmod, nevermind that part. Still I'm not sure where is
the right place to handle this.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110811/c455d781/attachment.sig>
