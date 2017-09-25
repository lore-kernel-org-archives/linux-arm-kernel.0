From: mdf@kernel.org (Moritz Fischer)
Date: Mon, 25 Sep 2017 09:11:36 -0700
Subject: [PATCH 1/2] arm: dts: Add support for National Instruments
 Project Sulfur SDRs
In-Reply-To: <314acb1f-1f0f-7893-70a8-9379c01112ac@xilinx.com>
References: <20170911232223.91894-1-mdf@kernel.org>
 <314acb1f-1f0f-7893-70a8-9379c01112ac@xilinx.com>
Message-ID: <20170925161136.GA12943@tyrael.ni.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

On Mon, Sep 25, 2017 at 10:19:44AM +0200, Michal Simek wrote:
> Hi Moritz
> 
> sorry for delay.

No problem.

> 
> On 12.9.2017 01:22, Moritz Fischer wrote:
> > Add support for the National Instruments Project Sulfur SDR
> > motherboards Rev 2,3 and 4.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  arch/arm/boot/dts/Makefile                |   3 +
> >  arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts |  84 +++++++++++++++++++
> >  arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts | 118 ++++++++++++++++++++++++++
> >  arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts |  26 ++++++
> >  arch/arm/boot/dts/zynq-ni-sulfur.dtsi     | 133 ++++++++++++++++++++++++++++++
> >  5 files changed, 364 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev2.dts
> >  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev3.dts
> >  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur-rev4.dts
> >  create mode 100644 arch/arm/boot/dts/zynq-ni-sulfur.dtsi
> 
> Is this publicly available board?

Will be in Q1 2018 was announced at GRCon'17 ([1]).
Some of the Rev3s are currently deployed in Norway as part of a radar
system.

> I am not quite sure we should apply these dts files. There are a lot of
> boards with zynq and there must be any strong argument for applying this
> to the tree. For arm32 with even flat tree structure.

What's the issue with merging them, except for having 3 more files? 

> Arnd: Do you have any policy about it?
> 
> Thanks,
> Michal

Thanks,

Moritz

[1] https://drive.google.com/file/d/0B-CV_07uSBIuODc5bmV2QXhnODA/view
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/0827281e/attachment.sig>
