From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Jun 2017 03:06:52 -0700
Subject: [PATCH 0/6] Init Clock frequences for accelerators
In-Reply-To: <ea1b56dd-1a91-42a1-6247-2acd0dcc1dab@ti.com>
References: <20170607212730.33002-1-s-anna@ti.com>
 <20170612073635.GT3730@atomide.com>
 <ea1b56dd-1a91-42a1-6247-2acd0dcc1dab@ti.com>
Message-ID: <20170612100652.GW3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170612 01:36]:
> On 12/06/17 10:36, Tony Lindgren wrote:
> > * Suman Anna <s-anna@ti.com> [170607 14:31]:
> > > Hi Tony,
> > > 
> > > The following series configures the initial frequencies for the required
> > > DPLLs and corresponding output divider clocks used by various remoteproc
> > > accelerators (DSP, IVAHD) on OMAP4, OMAP5 & DRA7xx/AM57xx SoCs and the
> > > GPU on DRA7xx/AM57xx SoCs. All these devices require Adaptive Voltage
> > > Scaling (AVS) to be programmed at all OPPs at boot time, which is
> > > programmed in the bootloader. Furthermore, DVFS is not supported on
> > > these domains implying a one-time OPP clock frequency setup.
> > 
> > Tero, care to comment or ack this series?
> 
> These have been in use in TI releases for quite a while already, and look
> fine, thus:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>
> 
> (Didn't quite think my ack was needed for them so didn't respond earlier,
> sorry.)

OK thanks applying all into omap-for-v4.13/dt.

Regards,

Tony
