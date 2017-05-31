From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 May 2017 10:20:32 -0700
Subject: [PATCH] ARM: dts: am43xx-clocks: Add support for CLKOUT2
In-Reply-To: <35f3b51b-d93f-5a65-8a63-26302d3c5815@ti.com>
References: <20170524084341.16698-1-peter.ujfalusi@ti.com>
 <20170526155212.GG3717@atomide.com>
 <35f3b51b-d93f-5a65-8a63-26302d3c5815@ti.com>
Message-ID: <20170531172032.GI3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [170529 01:31]:
> On 26/05/17 18:52, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [170524 01:47]:
> > > Add the needed clock nodes for the CLKOUT2 to be usable by boards.
> > 
> > Tero, care to ack?
> 
> I can't test the actual clock itself but the patch looks fine based on TRM,
> and doesn't seem to cause any issues either so:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

OK thanks applying into omap-for-v4.13/dt.

Tony
