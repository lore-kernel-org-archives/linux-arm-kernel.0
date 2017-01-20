From: yuantian.tang@nxp.com (Y.T. Tang)
Date: Fri, 20 Jan 2017 03:05:57 +0000
Subject: [PATCH] ahci: qoriq: added ls2088a platforms support
In-Reply-To: <20170118195351.GD9171@mtj.duckdns.org>
References: <1484633521-10938-1-git-send-email-yuantian.tang@nxp.com>
 <20170118195351.GD9171@mtj.duckdns.org>
Message-ID: <DB6PR0402MB283718AD367DBE4E6EEEE31FF0710@DB6PR0402MB2837.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Tejun Heo [mailto:htejun at gmail.com] On Behalf Of Tejun Heo
> Sent: Thursday, January 19, 2017 3:54 AM
> To: Y.T. Tang <yuantian.tang@nxp.com>
> Cc: robh+dt at kernel.org; mark.rutland at arm.com; linux-ide at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] ahci: qoriq: added ls2088a platforms support
> 
> On Tue, Jan 17, 2017 at 02:12:01PM +0800, yuantian.tang at nxp.com wrote:
> > From: Tang Yuantian <Yuantian.Tang@nxp.com>
> >
> > Ls2088a is new introduced arm-based soc with sata support with
> > following features:
> > 1. Complies with the serial ATA 3.0 specification and the AHCI 1.3.1
> >    specification
> > 2. Contains a high-speed descriptor-based DMA controller 3. Supports
> > the following:
> >    a. Speeds of 1.5 Gb/s (first-generation SATA), 3 Gb/s
> >       (second-generation SATA), and 6 Gb/s (third-generation SATA)
> >    b. FIS-based switching
> >    c. Native command queuing (NCQ) commands
> >    d. Port multiplier operation
> >    e. Asynchronous notification
> >    f. SATA BIST mode
> >
> > Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> 
> Reverted due to build failure.  Did you even try to compile it before
> submission?  We all make mistakes and that's fine but this one seems a bit
> too careless.  Please don't do this.
> 

Sorry for the trouble.
I never send a patch without testing.  This patch depends on other two patches which I sent a long time ago which I thought they were merged.
Anyway, my mistake.
I will resend all the patches with correct order.

Regards,
Yuantian

> Thanks.
> 
> --
> tejun
