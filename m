From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Sep 2014 09:58:18 -0700
Subject: [PATCH] ARM: dts: DRA7: Add PMU nodes
In-Reply-To: <20140917142503.GA11856@kahuna>
References: <1408456440-30171-1-git-send-email-nm@ti.com>
 <540719FC.5070803@ti.com> <20140917142503.GA11856@kahuna>
Message-ID: <20140918165817.GI14505@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140917 07:26]:
> On 08:39-20140903, Nishanth Menon wrote:
> > On 08/19/2014 08:54 AM, Nishanth Menon wrote:
> > > From: Lucas Weaver <l-weaver@ti.com>
> > > 
> > > DRA74x and DRA72x family of processors vary slightly in the number
> > > of CPUs. So, add different instances of PMU for each of these processor
> > > groups. Further, since the interrupts bypass crossbar and are directly
> > > connected to GIC, mark the dts nodes with relevant information.
> > > 
> > > Tested with perf utility.
> > > 
> > > Reviewed-by: Felipe Balbi <balbi@ti.com>
> > > Signed-off-by: Lucas Weaver <l-weaver@ti.com>
> > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > ---
> > Hi,
> > Gentle ping..
> 
> Tony,
> I dont see this patch in omap-for-v3.18/dt
> 
> Is there anyway you might consider pulling this for 3.18?
> 
> Patchworks link:
> https://patchwork.kernel.org/patch/4743121/

Thanks applying into omap-for-v3.18/dt.

Tony
