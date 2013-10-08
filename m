From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Oct 2013 14:27:18 -0700
Subject: [PATCH] ARM: DRA7: realtime_counter: Add ratio registers for
 20MHZ sys-clk frequency
In-Reply-To: <5239A98E.3060908@ti.com>
References: <1379503211-26229-1-git-send-email-r.sricharan@ti.com>
 <5239A98E.3060908@ti.com>
Message-ID: <20131008212718.GS8313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130918 06:32]:
> On Wednesday 18 September 2013 07:20 AM, Sricharan R wrote:
> > The real time counter also called master counter, is a free-running
> > counter. It produces the count used by the CPU local timer peripherals
> > in the MPU cluster. The timer counts at a rate of 6.144 MHz.
> > 
> > The ratio registers are missing for a sys-clk of 20MHZ which is used
> > by DRA7 socs. So because of this, the counter was getting wrongly
> > programmed for a sys-clk of 38.4Mhz(default). So adding the ratio
> > registers for 20MHZ sys-clk.
> > 
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Sricharan R <r.sricharan@ti.com>
> > ---
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Applying into omap-for-v3.13/soc thanks.

Tony
