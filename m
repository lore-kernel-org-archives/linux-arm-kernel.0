From: navam@xilinx.com (Nava kishore Manne)
Date: Wed, 24 Oct 2018 06:32:21 +0000
Subject: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
In-Reply-To: <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
References: <20181020084805.29103-1-nava.manne@xilinx.com>
 <CANk1AXTUu=qiko9_sLrxrNxBmX7p0OXVxNN13p1uBirNh+Ymtw@mail.gmail.com>
Message-ID: <BYAPR02MB4710AD8C0FD51D14A7A40395C2F60@BYAPR02MB4710.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

Thanks for the reply...
Please find my response inline.

> -----Original Message-----
> From: Alan Tull [mailto:atull at kernel.org]
> Sent: Monday, October 22, 2018 9:29 PM
> To: Nava kishore Manne <navam@xilinx.com>
> Cc: Moritz Fischer <mdf@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Michal Simek <michals@xilinx.com>;
> Rajan Vaja <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-
> fpga at vger.kernel.org; open list:OPEN FIRMWARE AND FLATTENED DEVICE
> TREE BINDINGS <devicetree@vger.kernel.org>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE <linux-arm-
> kernel at lists.infradead.org>; linux-kernel <linux-kernel@vger.kernel.org>;
> kishore m <chinnikishore369@gmail.com>
> Subject: Re: [PATCH 0/3] Add Bitstream configuration support for ZynqMP
> 
> On Fri, Oct 19, 2018 at 3:49 AM Nava kishore Manne
> <nava.manne@xilinx.com> wrote:
> 
> Hi Nava,
> 
> >
> > This series of patches are created On top of the below repo.
> > //git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> > BRANCH: next/drivers.
> 
> IIUC this is dependent on some patches that aren't released yet.
> Please make this explicit by specifying which patches this is dependent on in
> each future submission of new versions.  It will help so that I don't send these
> upstream prematurely and introduce build breaks.  Of course, we can keep
> reviewing!
> 

This driver depends on the below series of patches
https://lkml.org/lkml/2018/9/12/983 
Which is got integrated into the below upstream repo.
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/tree/drivers/firmware/xilinx?h=for-next 
I hope arm maintainers will send the pull-request in soon to integrate these patches with main repo.
Will add the required info for the dependent patches in s-o-b section 

Regards,
Navakishore.
