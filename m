From: dinh.nguyen@intel.com (Nguyen, Dinh)
Date: Wed, 29 Aug 2018 15:05:11 +0000
Subject: [RFC] Rename socfpga_cyclone5_de0_sockit.dts to
 socfpga_cyclone5_de0_nano_soc.dts
In-Reply-To: <2a991ba5-9746-007b-720a-91e4c4615d4d@denx.de>
References: <fd0f01e5-41a2-6a24-2ce4-482b30b348b6@denx.de>
 <73bm9lwn3t.fsf@pengutronix.de>
 <b29e529a-f7bd-71d2-615e-9f850858ed4d@denx.de>
 <BA1B5AF7D118E146A437E44412B829131564F1F5@fmsmsx122.amr.corp.intel.com>
 <9bdee446-5bc6-1171-eded-3c01623de820@denx.de>
 <BA1B5AF7D118E146A437E44412B829131564F225@fmsmsx122.amr.corp.intel.com>
 <2a991ba5-9746-007b-720a-91e4c4615d4d@denx.de>
Message-ID: <BA1B5AF7D118E146A437E44412B829131564F246@fmsmsx122.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Marek Vasut <marex@denx.de>
> Sent: Wednesday, August 29, 2018 10:03 AM
> To: Nguyen, Dinh <dinh.nguyen@intel.com>; Steffen Trumtrar
> <s.trumtrar@pengutronix.de>
> Cc: linux ARM <linux-arm-kernel@lists.infradead.org>; Dinh Nguyen
> <dingnuyen@kernel.org>; Jan Kiszka <jan.kiszka@siemens.com>; Rob Herring
> <robh+dt@kernel.org>; Westergreen, Dalon <dalon.westergreen@intel.com>
> Subject: Re: [RFC] Rename socfpga_cyclone5_de0_sockit.dts to
> socfpga_cyclone5_de0_nano_soc.dts
> 
> On 08/29/2018 04:54 PM, Nguyen, Dinh wrote:
> >
> >
> >> -----Original Message-----
> >> From: Marek Vasut <marex@denx.de>
> >> Sent: Wednesday, August 29, 2018 9:47 AM
> >> To: Nguyen, Dinh <dinh.nguyen@intel.com>; Steffen Trumtrar
> >> <s.trumtrar@pengutronix.de>
> >> Cc: linux ARM <linux-arm-kernel@lists.infradead.org>; Dinh Nguyen
> >> <dingnuyen@kernel.org>; Jan Kiszka <jan.kiszka@siemens.com>; Rob
> >> Herring <robh+dt@kernel.org>; Westergreen, Dalon
> >> <dalon.westergreen@intel.com>
> >> Subject: Re: [RFC] Rename socfpga_cyclone5_de0_sockit.dts to
> >> socfpga_cyclone5_de0_nano_soc.dts
> >>
> >> On 08/29/2018 04:40 PM, Nguyen, Dinh wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Marek Vasut <marex@denx.de>
> >>>> Sent: Wednesday, August 29, 2018 5:34 AM
> >>>> To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >>>> Cc: linux ARM <linux-arm-kernel@lists.infradead.org>; Dinh Nguyen
> >>>> <dingnuyen@kernel.org>; Jan Kiszka <jan.kiszka@siemens.com>; Rob
> >>>> Herring <robh+dt@kernel.org>; See, Chin Liang
> >>>> <chin.liang.see@intel.com>; Tan, Ley Foon <ley.foon.tan@intel.com>;
> >>>> Nguyen, Dinh <dinh.nguyen@intel.com>
> >>>> Subject: Re: [RFC] Rename socfpga_cyclone5_de0_sockit.dts to
> >>>> socfpga_cyclone5_de0_nano_soc.dts
> >>>>
> >>>> On 08/29/2018 11:14 AM, Steffen Trumtrar wrote:
> >>>>>
> >>>>> Marek Vasut <marex@denx.de> writes:
> >>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> I was recently experimenting with the DE0 Nano SoC / Atlas SoC .
> >>>>>> I had a hard time finding the right DT for the board, but then
> >>>>>> was suggested that the DT for the board is
> >>>>>> socfpga_cyclone5_de0_sockit.dts . This did not make sense to me,
> >>>>>> since SoCKit is a different board altogether. But the DTS seems
> >>>>>> to be indeed
> >>>> for the DE0 Nano SoC.
> >>>>>>
> >>>>>> To fix up this confusion, I'd propose renaming of the
> >>>>>> socfpga_cyclone5_de0_sockit.dts to
> >>>>>> socfpga_cyclone5_de0_nano_soc.dts to match the label on the package
> .
> >>>>>>
> >>>>>> What do you think ?
> >>>>>
> >>>>> Ack. This confusion came up multiple times. The barebox-specific
> >>>>> dts "overlay"
> >>>>> is already named socfpga_cyclone5_de0_nano_soc.dts because of this.
> >>>>
> >>>> The DT in U-Boot is also called socfpga_cyclone5_de0_nano_soc.dts
> >>>> since forever. I'd be happy to send a patch if the Altera folks are fine with
> it?
> >>>>
> >>>
> >>> I'm fine with it. But this is the commit message when this board was
> >>> originally
> >> create:
> >>>
> >>>     The Terasic DE0 Atlas board is also known as the DE0-Nano board.
> >>>     This patch adds the DTS board file for the DE0-Nano Sockit board, and not
> >>>     the DE0 Nano "Development Board".
> >>
> >> But it was never called SoCkit anywhere , no documentation lists it
> >> as sockit. It is either DE0-Nano-SoC or Atlas-SoC , but that's it.
> >
> > https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No
> > =941
> 
> Half of the boards from terasic have this "kit" suffix in the listing, but with a
> space in front of it. The SoCkit (without space) is:
> 
> https://www.terasic.com.tw/cgi-
> bin/page/archive.pl?Language=English&CategoryNo=167&No=816
> 

Right, just noticed that. Pretty clear naming scheme, I think! ?

Dinh
