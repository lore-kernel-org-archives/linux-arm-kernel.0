From: minghuan.lian@nxp.com (Minghuan Lian)
Date: Fri, 22 Apr 2016 07:53:46 +0000
Subject: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller support
In-Reply-To: <5719D614.1080400@arm.com>
References: <1457321782-3245-1-git-send-email-Minghuan.Lian@nxp.com>
 <1457321782-3245-2-git-send-email-Minghuan.Lian@nxp.com>
 <20160307095021.7f9f7484@arm.com>
 <CADRPPNRU=qy34p4hzYvzBPrt2uabSQfc0Xdd8K5v5B_JW01QJA@mail.gmail.com>
 <5719D614.1080400@arm.com>
Message-ID: <VI1PR04MB161534A98E15E93263B07DBFE86F0@VI1PR04MB1615.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Please see the link:
https://patchwork.kernel.org/patch/8649241/

Rob Herring has given the ACK.

I have submitted the v6 patch:  https://patchwork.kernel.org/patch/8649251/
Please apply the latest the patch after you review.

Thank you very much.


Regard,
Minghuan


> -----Original Message-----
> From: Marc Zyngier [mailto:marc.zyngier at arm.com]
> Sent: Friday, April 22, 2016 3:43 PM
> To: Leo Li <pku.leo@gmail.com>
> Cc: Minghuan Lian <minghuan.lian@nxp.com>;
> linux-arm-kernel at lists.infradead.org; lkml <linux-kernel@vger.kernel.org>;
> Thomas Gleixner <tglx@linutronix.de>; Jason Cooper
> <jason@lakedaemon.net>; Roy Zang <roy.zang@nxp.com>; Mingkai Hu
> <mingkai.hu@nxp.com>; Stuart Yoder <stuart.yoder@nxp.com>; Yang-Leo Li
> <leoyang.li@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <Mark.Rutland@arm.com>
> Subject: Re: [PATCH 2/2 v5] irqchip/Layerscape: Add SCFG MSI controller
> support
> 
> On 22/04/16 06:33, Leo Li wrote:
> > On Mon, Mar 7, 2016 at 3:50 AM, Marc Zyngier <marc.zyngier@arm.com>
> wrote:
> >> On Mon, 7 Mar 2016 11:36:22 +0800
> >> Minghuan Lian <Minghuan.Lian@nxp.com> wrote:
> >>
> >>> Some kind of NXP Layerscape SoC provides a MSI
> >>> implementation which uses two SCFG registers MSIIR and
> >>> MSIR to support 32 MSI interrupts for each PCIe controller.
> >>> The patch is to support it.
> >>>
> >>> Signed-off-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> >>
> >> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> >>
> >> The DT binding still needs an Ack from the DT maintainers though (cc'd).
> >
> > Marc,
> >
> > Who will be responsible to pick this driver?  I see you are also one
> > of the maintainers for irqchip.  Can you pick up the driver?  The
> > binding has already gotten ACKed by the device tree maintainer.
> 
> Can you point me to this Ack? I can't see any trace of it in my Inbox.
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny...
