From: JOLLYS@xilinx.com (Jolly Shah)
Date: Fri, 3 Aug 2018 17:59:35 +0000
Subject: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
 ZynqMP core
In-Reply-To: <d153598d-8d09-fb32-f68e-6fc4975eb9ce@xilinx.com>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
 <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
 <19376df2-fdd4-12e3-da4c-37106fffed19@xilinx.com>
 <153262301567.48062.15432354725863055071@swboyd.mtv.corp.google.com>
 <e5448935-770a-5c14-438c-23a652b17822@xilinx.com>
 <153324358299.10763.8724416723915219268@swboyd.mtv.corp.google.com>
 <d153598d-8d09-fb32-f68e-6fc4975eb9ce@xilinx.com>
Message-ID: <CY1PR02MB2138A6BBE829400CEABA5AAFB8230@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Michal Simek
> Sent: Thursday, August 02, 2018 11:14 PM
> To: Stephen Boyd <sboyd@kernel.org>; ard.biesheuvel at linaro.org;
> dmitry.torokhov at gmail.com; gregkh at linuxfoundation.org;
> hkallweit1 at gmail.com; keescook at chromium.org; linux-clk at vger.kernel.org;
> mark.rutland at arm.com; matt at codeblueprint.co.uk; mingo at kernel.org;
> mturquette at baylibre.com; robh+dt at kernel.org; sboyd at codeaurora.org;
> sudeep.holla at arm.com; Jolly Shah <JOLLYS@xilinx.com>; Michal Simek
> <michals@xilinx.com>
> Cc: devicetree at vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for
> ZynqMP core
> 
> On 2.8.2018 22:59, Stephen Boyd wrote:
> > Quoting Michal Simek (2018-07-30 05:50:42)
> >> On 26.7.2018 18:36, Stephen Boyd wrote:
> >>> Quoting Michal Simek (2018-07-25 02:51:14)
> >>>> On 24.7.2018 20:14, Jolly Shah wrote:
> >>>>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
> >>>>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create
> >>>>>>> mode
> >>>>>>> 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
> >>>>>>>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
> >>>>>>>
> >>>>>>
> >>>>>> It looks pretty calm over the last several series that's why when
> >>>>>> I get an answer from Stephen or Mike I will take this series via my tree
> and arm-soc tree.
> >>>>>>
> >>>>>> I have applied 01-08 here
> >>>>>>  https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Michal
> >>>>>
> >>>>>
> >>>>> Thanks for merging the patches.
> >>>>> By mistake I added ?Reviewed-by: Stephen Boyd sboyd at kernel.org? for
> firmware bindings (Patch01).  Stephen had reviewed clock bindings only.  Please
> suggest if I should send a new version with that fix.
> >>>>
> >>>> I have fixed that in my branch and I have asked Shephen to look at
> >>>> clk over chat.
> >>>>
> >>>
> >>> I have some unresolved review comments on v9. I'll give reviewed-by
> >>> when that discussion is resolved.
> >>
> >> ok. Do you want to take them via clk tree or via arm-soc tree?
> >>
> >
> > I'm fine for the clk patch to go via arm-soc if that makes it easier.
> >
> 
> ok. Great.
> Jolly: Please address all Stephen's comments that we can move.
> 
> Thanks,
> Michal

Posted V11 patch set with all his comments addressed. 

Thanks,
Jolly Shah
