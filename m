From: leoyang.li@nxp.com (Leo Li)
Date: Mon, 26 Nov 2018 22:35:23 +0000
Subject: [PATCH v3 2/2] arm64: dts: Add support for NXP LS1028A SoC
In-Reply-To: <20181126144208.GC31334@dragon>
References: <1542156591-3224-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <1542156591-3224-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20181126144208.GC31334@dragon>
Message-ID: <AM6PR04MB586352129DF2A1DF6056BC048FD70@AM6PR04MB5863.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Monday, November 26, 2018 8:42 AM
> To: Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>
> Cc: devicetree at vger.kernel.org; Harninder Rai <harninder.rai@nxp.com>;
> Sudhanshu Gupta <sudhanshu.gupta@nxp.com>; linux-arm-
> kernel at lists.infradead.org; Leo Li <leoyang.li@nxp.com>
> Subject: Re: [PATCH v3 2/2] arm64: dts: Add support for NXP LS1028A SoC
> 
> On Wed, Nov 14, 2018 at 05:30:52AM +0000, Bhaskar Upadhaya wrote:
> > LS1028A contains two ARM v8 CortexA72 processor cores with 32 KB L1-D
> > cache and 48 KB L1-I cache
> >
> > Features summary
> >  Two 32-bit / 64-bit ARM v8 Cortex-A72 CPUs
> >   - Arranged as single clusters of two cores sharing a 1 MB L2 cache
> >   - Speed Up to 1.3 GHz
> >   - Support for cluster power-gating.
> >  Cache coherent interconnect (CCI-400)
> >   - Hardware-managed data coherency
> >   - Up to 400 MHz
> >  32-bit DDR4 SDRAM memory controller with ECC  Two PCIe 3.0
> > controllers  One serial ATA (SATA 3.0) controller  Two high-speed USB
> > 3.0 controllers with integrated PHY
> >
> >  Following levels of DTSI/DTS files have been created for the LS1028A
> >   SoC family:
> >
> >          - fsl-ls1028a.dtsi:
> >                  DTS-Include file for NXP LS1028A SoC.
> >
> >          - fsl-ls1028a-qds.dts:
> >                  DTS file for NXP LS1028A QDS board.
> >
> >          - fsl-ls1028a-rdb.dts:
> >                  DTS file for NXP LS1028A RDB board
> >
> > Signed-off-by: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
> > Signed-off-by: Rai Harninder <harninder.rai@nxp.com>
> > Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
> 
> @Leo, looks good to you?

Yes.

Acked-by: Li Yang <leoyang.li@nxp.com>

Regards,
Leo
