From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 11:02:11 +0800
Subject: [PATCH v3 04/11] ARM: dts: imx6: add anatop phandle for usbphy
In-Reply-To: <20131105031654.GL19770@S2101-09.ap.freescale.net>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
 <1383616183-10511-5-git-send-email-peter.chen@freescale.com>
 <20131105024130.GG19770@S2101-09.ap.freescale.net>
 <20131105025307.GC13472@shlinux1.ap.freescale.net>
 <20131105031654.GL19770@S2101-09.ap.freescale.net>
Message-ID: <20131105030210.GE13472@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 11:16:57AM +0800, Shawn Guo wrote:
> On Tue, Nov 05, 2013 at 10:53:08AM +0800, Peter Chen wrote:
> > On Tue, Nov 05, 2013 at 10:41:33AM +0800, Shawn Guo wrote:
> > > On Tue, Nov 05, 2013 at 09:49:36AM +0800, Peter Chen wrote:
> > > > Add anatop phandle for usbphy
> > > > 
> > > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > > ---
> > > >  arch/arm/boot/dts/imx6qdl.dtsi |    2 ++
> > > >  1 files changed, 2 insertions(+), 0 deletions(-)
> > > 
> > > Does imx6sl.dtsi need the same update?
> > > 
> > 
> > It is needed (for chipidea, it is the same), but I still have
> > no time to test on it. Will add them later.
> 
> So all "fsl,imx6sl-usbphy" code is untested so far?
> 
> Shawn

Yes, "fsl,imx23-usbphy" and "fsl,imx6q-usbphy" have been tested,
I will test imx6sl during this patchset review cycle.

-- 

Best Regards,
Peter Chen
