From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 19 Oct 2016 07:26:55 +0200
Subject: [PATCH 3/3] ARM: socfpga: defconfig: enable qspi
In-Reply-To: <alpine.DEB.2.02.1610181600570.27375@linux-builds1>
References: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
 <20161018074304.6744-3-s.trumtrar@pengutronix.de>
 <alpine.DEB.2.02.1610181600570.27375@linux-builds1>
Message-ID: <20161019052655.mlqxaj3mbtt5dhl7@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 04:03:01PM -0500, Dinh Nguyen wrote:
> On Tue, 18 Oct 2016, Steffen Trumtrar wrote:
> 
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm/configs/socfpga_defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> > index 9f84be5b3ac5..466050663c86 100644
> > --- a/arch/arm/configs/socfpga_defconfig
> > +++ b/arch/arm/configs/socfpga_defconfig
> 
> Thanks Steffen, all patches applied. I'll fixup the commit header for the DTS
> patches. The arm-soc maintainers prefer the DTS patches to be:
> 
> "ARM: dts: <platform>"

Oops.

Thanks,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
