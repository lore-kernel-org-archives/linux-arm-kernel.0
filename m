From: greg@kroah.com (Greg KH)
Date: Fri, 9 Dec 2011 15:58:07 -0800
Subject: [PATCH 0/3] Support Samsung S5P OHCI device and driver
In-Reply-To: <046f01ccb011$6d111370$47333a50$%kim@samsung.com>
References: <33510089.42761321876635907.JavaMail.weblogic@epv6ml08>
 <20111121172344.GA4483@kroah.com>
 <046f01ccb011$6d111370$47333a50$%kim@samsung.com>
Message-ID: <20111209235807.GC6680@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 07:10:17PM +0900, Kukjin Kim wrote:
> Greg KH wrote:
> > 
> > On Mon, Nov 21, 2011 at 11:57:16AM +0000, Jingoo Han wrote:
> > > > -----Original Message-----
> > > > From: Greg KH [mailto:greg at kroah.com]
> > > > Sent: Friday, November 18, 2011 4:12 AM
> > > > To: Jingoo Han
> > > > Cc: linux-arm-kernel at lists.infradead.org; linux-usb at vger.kernel.org;
> > > > linux-samsung-soc at vger.kernel.org; gregkh at suse.de;
> > > > stern at rowland.harvard.edu; kgene.kim at samsung.com;
> > yulgon.kim at samsung.com;
> > > > jy0922.shim at samsung.com
> > > > Subject: Re: [PATCH 0/3] Support Samsung S5P OHCI device and driver
> > > >
> > > > On Tue, Nov 15, 2011 at 06:49:58AM +0000, Jingoo Han wrote:
> > > > > Hello.
> > > > >
> > > > > This patch series adds USB OHCI device and initial driver for
> > Samsung
> > > > > S5P SoCs and is based from Linux 3.2-rc1. I have tested on SMDKV310
> > > > board
> > > > > using EXYNOS4.
> > > >
> > > > This is to be sent through some arm tree, not the usb tree, right?
> > > Right, 1st and 2nd patch are sent throught arm tree.
> > > However, 3rd patch is sent through the usb tree.
> > > Thanks.
> > > [PATCH 1/3] ARM: SAMSUNG: Add USB OHCI device
> > > [PATCH 2/3]  ARM: EXYNOS: Add USB OHCI support to SMDKV310 board
> > > [PATCH 3/3] USB: Add S5P OHCI diver
> > 
> Hi Greg,
> 
> Sorry for late response. I came back today from family vacation...
> 
> Anyway,
> 
> > So the third patch does not depend on the first two?  If it does, that
> > means I will get build errors in the USB tree when I apply that patch,
> > right?
> > 
> > If so, then all three should go through a single tree.
> > 
> Yes, right. This series would be handled in same tree so that we can avoid
> useless conflicts.
> 
> I commented small thing on 3rd patch. So I think, if you're ok on his
> updated patch, it can be sent to upstream via Samsung tree. Or your tree
> with my ack?

The samsung tree is fine to take these, thanks.

greg k-h
