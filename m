From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Feb 2016 07:58:36 -0800
Subject: [PATCH 0/3] omap: hwmod: add default reset handling support
In-Reply-To: <56B97572.6080100@ti.com>
References: <1454929941-23949-1-git-send-email-kishon@ti.com>
 <20160208204446.GC19432@atomide.com> <56B97572.6080100@ti.com>
Message-ID: <20160209155836.GI19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [160208 21:14]:
> Hi Tony,
> 
> On Tuesday 09 February 2016 02:14 AM, Tony Lindgren wrote:
> > Hi Kishon,
> > 
> > * Kishon Vijay Abraham I <kishon@ti.com> [160208 03:13]:
> >> Add a new hwmod flag to indicate custom reset handling and use it
> >> for devices that require custom reset handling (like dsp, ipu, iva).
> >>
> >> Tested PCIe on dra7-evm and dra72-evm.
> >> I need help in testing DSP, IPU, IVA, PRU, GFX, M3 in other platforms.
> >> Or a way to test these cores to see if reset is not broken. Suman?
> >>
> >> I'll post this series once again after performing these tests.
> > 
> > Do we also still need to patch something in the pcie driver too
> > or can all that be left out now?
> 
> With this series changes in PCIe driver is not required at all.

OK good to hear.

Thanks,

Tony
