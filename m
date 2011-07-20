From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 20 Jul 2011 11:21:45 +0000
Subject: [PATCH 1/7] consolidate definitions and structures to share
	among platforms
In-Reply-To: <20110720111630.GO764@legolas.emea.dhcp.ti.com>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-2-git-send-email-tony.lin@freescale.com>
	<20110720105933.GJ764@legolas.emea.dhcp.ti.com>
	<97D3A72708D04647A5AC84A04996E5B5161640@039-SN1MPN1-006.039d.mgd.msft.net>
	<20110720111630.GO764@legolas.emea.dhcp.ti.com>
Message-ID: <97D3A72708D04647A5AC84A04996E5B51616B8@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi at ti.com]
> Sent: Wednesday, July 20, 2011 7:17 PM
> To: Lin Tony-B19295
> Cc: balbi at ti.com; linux-usb at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; koen.beel.barco at gmail.com
> Subject: Re: [PATCH 1/7] consolidate definitions and structures to share
> among platforms
> 
> Hi,
> 
> On Wed, Jul 20, 2011 at 11:03:56AM +0000, Lin Tony-B19295 wrote:
> > > I believe this patch will cause build breakage since ehci-mxc.c
> > > doesn't include <linux/fsl_devices.h> ??
> > Ehci-mxc.c does include <linux/fsl_devices.h>, please check patch 5/7.
> > Thanks
> 
> that's too late. You will always have the broken bisection point.
> 
Ok, I'll re-org my patch series later. Thank you.

> --
> balbi
