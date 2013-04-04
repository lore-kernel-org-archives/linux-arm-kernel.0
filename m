From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 04 Apr 2013 00:08:31 -0700 (PDT)
Subject: APE6EVM and Runtime PM
In-Reply-To: <20130404061429.GJ28297@verge.net.au>
References: <20130404020019.GA7163@verge.net.au>
 <87wqsjdlhv.wl%kuninori.morimoto.gx@renesas.com>
 <20130404044101.GG28297@verge.net.au>
 <uy5cy7tkp.wl%kuninori.morimoto.gx@renesas.com>
 <20130404061429.GJ28297@verge.net.au>
Message-ID: <87r4iqepsk.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> > I didn't check real board,
> > but I guess current SMSC IRQ came from IRQC,
> > and this IRQC needs MSTP 407.
> > But IRQC driver seems doesn't support PM_RUNTIME at this point.
> > 
> > Does your issue solve by adding MSTP 407 with CLK_ENABLE_ON_INIT ?
> > I'm not sure this is good solution, but quick-hack
> 
> Thanks!
> 
> I will post a patch to add pm_runtime support to the IRQC Driver.
> It seems to allow SMSC + RUNTIME_PM to function on the APE6EVM.

Cool !!
Thanks

Best regards
---
Kuninori Morimoto
