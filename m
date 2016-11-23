From: hongtao.jia@nxp.com (Troy Jia)
Date: Wed, 23 Nov 2016 07:14:30 +0000
Subject: [PATCH V3 1/2] powerpc/mpc85xx: Update TMU device tree node for
 T1040/T1042
In-Reply-To: <1479884833.21746.44.camel@buserror.net>
References: <1477361742-589-1-git-send-email-hongtao.jia@nxp.com>
 <1479884833.21746.44.camel@buserror.net>
Message-ID: <AM4PR0401MB18433E61BF1550676423E255EBB70@AM4PR0401MB1843.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Scott Wood [mailto:oss at buserror.net]
> Sent: Wednesday, November 23, 2016 3:07 PM
> To: Troy Jia <hongtao.jia@nxp.com>; rui.zhang at intel.com; edubezval at gmail.com;
> robh+dt at kernel.org; Scott Wood <scott.wood@nxp.com>; shawnguo at kernel.org
> Cc: devicetree at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V3 1/2] powerpc/mpc85xx: Update TMU device tree node for
> T1040/T1042
> 
> On Tue, 2016-10-25 at 10:15 +0800, Jia Hongtao wrote:
> > From: Hongtao Jia <hongtao.jia@nxp.com>
> >
> > Update #thermal-sensor-cells from 0 to 1 according to the new binding.
> > The sensor specifier added is the monitoring site ID, and represents
> > the "n" in TRITSRn and TRATSRn.
> >
> > Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> 
> Where can I find this new binding? ?As of the current linux-next I don't see anything
> in qoriq-thermal.txt about this.

Hi Rui Zhang,

As we discussed before. The time was inappropriate as merge window was about to close.
So do you have any plan for applying the binding file recently?

-Hongtao.
