From: JOLLYS@xilinx.com (Jolly Shah)
Date: Tue, 17 Jul 2018 20:01:40 +0000
Subject: [PATCH v9 07/10] firmware: xilinx: Add debugfs for IOCTL API
In-Reply-To: <153111415833.143105.8701882244160397855@swboyd.mtv.corp.google.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-8-git-send-email-jollys@xilinx.com>
 <153111415833.143105.8701882244160397855@swboyd.mtv.corp.google.com>
Message-ID: <SN1PR02MB3758432C38CC9580BC96182DB85C0@SN1PR02MB3758.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for the review,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Sunday, July 08, 2018 10:29 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; ard.biesheuvel at linaro.org;
> dmitry.torokhov at gmail.com; gregkh at linuxfoundation.org;
> hkallweit1 at gmail.com; keescook at chromium.org; linux-clk at vger.kernel.org;
> mark.rutland at arm.com; matt at codeblueprint.co.uk; Michal Simek
> <michals@xilinx.com>; mingo at kernel.org; mturquette at baylibre.com;
> robh+dt at kernel.org; sboyd at codeaurora.org; sudeep.holla at arm.com
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Jolly Shah
> <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v9 07/10] firmware: xilinx: Add debugfs for IOCTL API
> 
> Quoting Jolly Shah (2018-06-20 10:40:32)
> > From: Rajan Vaja <rajanv@xilinx.com>
> >
> > Add debugfs file to set/get IOCTL using debugfs interface.
> 
> IOCTLs and debugfs aren't the same thing. Why are the two being mixed
> together? Is some sort of userspace ABI being created here to control clks with
> usermode drivers?

This is not standard ioctl. This is type of ZynqMP API just like other APIs. This debugfs is created to debug ZynqMP IOCTL API.

Thanks,
Jolly Shah
