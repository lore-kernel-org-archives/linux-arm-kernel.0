From: JOLLYS@xilinx.com (Jolly Shah)
Date: Fri, 2 Feb 2018 19:50:05 +0000
Subject: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
In-Reply-To: <20180201102730.33q4xrjw3vhrgk4i@lakrids.cambridge.arm.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-2-git-send-email-jollys@xilinx.com>
 <20180131180354.mqf4gvvprdtycbn5@lakrids.cambridge.arm.com>
 <CY1PR0201MB076454E915A6E6947A39F04BB8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
 <20180201102730.33q4xrjw3vhrgk4i@lakrids.cambridge.arm.com>
Message-ID: <DM2PR0201MB0767C06A1B7A47DB79723C96B8F90@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Thursday, February 01, 2018 2:28 AM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel at linaro.org; mingo at kernel.org;
> gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; michal.simek at xilinx.com; robh+dt at kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 1/4] dt-bindings: firmware: Add bindings for ZynqMP
> firmware
> 
> On Thu, Feb 01, 2018 at 01:04:45AM +0000, Jolly Shah wrote:
> > > > +Xilinx Zynq MPSoC Firmware Device Tree Bindings
> > > > +
> > > > +The zynqmp-firmware node describes the interface to platform firmware.
> > >
> > > Is there any documentation for this that can be referred to?
> > >
> >
> > Will add more information about supported APIs in next version patch.
> > Below document describes interface APIs though it is not latest.
> > https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-a
> > pi.pdf
> 
> Thanks for the link.
> 
> It might be better for the compatible string to be "xlnx,zynqmp-eemi", to make it
> clear which firmware interfaces are being described, assuming that this being is
> only intended to cover EEMI.
> 
> Thanks,
> Mark.

It is interface to firmware be it ATF/PMU. EEMI is part of it. 

Thanks,
Jolly Shah
