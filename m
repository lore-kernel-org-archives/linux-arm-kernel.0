From: JOLLYS@xilinx.com (Jolly Shah)
Date: Fri, 15 Jun 2018 16:45:43 +0000
Subject: [PATCH v8 03/10] firmware: xilinx: Add zynqmp IOCTL API for
 device control
In-Reply-To: <3044c2b9-2268-dfcb-2d45-0117c6f91a8d@infradead.org>
References: <1529000862-11510-1-git-send-email-jollys@xilinx.com>
 <1529000862-11510-4-git-send-email-jollys@xilinx.com>
 <3044c2b9-2268-dfcb-2d45-0117c6f91a8d@infradead.org>
Message-ID: <BL0PR02MB374784B711D2D2AF9773CA6DB87C0@BL0PR02MB3747.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap at infradead.org]
> Sent: Thursday, June 14, 2018 1:45 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> mingo at kernel.org; gregkh at linuxfoundation.org; matt at codeblueprint.co.uk;
> sudeep.holla at arm.com; hkallweit1 at gmail.com; keescook at chromium.org;
> dmitry.torokhov at gmail.com; mturquette at baylibre.com;
> sboyd at codeaurora.org; michal.simek at xilinx.com; robh+dt at kernel.org;
> mark.rutland at arm.com; linux-clk at vger.kernel.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v8 03/10] firmware: xilinx: Add zynqmp IOCTL API for device
> control
> 
> On 06/14/2018 11:27 AM, Jolly Shah wrote:
> > From: Rajan Vaja <rajanv@xilinx.com>
> >
> > Add ZynqMP firmware IOCTL API to control and configure devices like
> > PLLs, SD, Gem, etc.
> >
> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h |  2 ++
> >  2 files changed, 22 insertions(+)
> 
> Hi,
> 
> Does this driver claim (implement) some specific ioctl code or ID?
> 
> If so, its ioctl numbers should be documented in Documentation/ioctl/ioctl-
> number.txt.
> 

This is not system IOCTL. This is parameter to ZynqMP specific API.

Thanks,
Jolly Shah

> thanks,
> --
> ~Randy
