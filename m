From: tony@atomide.com (Tony Lindgren)
Date: Thu, 24 Nov 2016 06:29:10 -0800
Subject: [PATCH v2] ARM: dts: AM571x-IDK Initial Support
In-Reply-To: <CAL_JsqLv2t0qzJ1V6NGPj3iy9tOmMcnr3nsHxojb9aJxp9+8BQ@mail.gmail.com>
References: <20161122041732.8385-1-lokeshvutla@ti.com>
 <CAL_JsqLv2t0qzJ1V6NGPj3iy9tOmMcnr3nsHxojb9aJxp9+8BQ@mail.gmail.com>
Message-ID: <20161124142910.GM4082@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh+dt@kernel.org> [161122 07:43]:
> On Mon, Nov 21, 2016 at 10:17 PM, Lokesh Vutla <lokeshvutla@ti.com> wrote:
> > From: Schuyler Patton <spatton@ti.com>
> >
> > The AM571x-IDK board is a board based on TI's AM5718 SOC
> > which has a single core 1.5GHz A15 processor. This board is a
> > development platform for the Industrial market with:
> > - 1GB of DDR3L
> > - Dual 1Gbps Ethernet
> > - HDMI,
> > - PRU-ICSS
> > - uSD
> > - 16GB eMMC
> > - CAN
> > - RS-485
> > - PCIe
> > - USB3.0
> > - Video Input Port
> > - Industrial IO port and expansion connector
> >
> > The link to the data sheet and TRM can be found here:
> >
> > http://www.ti.com/product/AM5718
> >
> > Initial support is only for basic peripherals.
> >
> > Signed-off-by: Schuyler Patton <spatton@ti.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > ---
> > Cahnges since v1:
> > - Dropped "ti,dra722", and "ti,dra72" from compatibles
> > - Fixes few node names as suggested by Rob.
> > Logs: http://pastebin.ubuntu.com/23515001/
> 
> Please add acks when posting new versions.

I applied this with your ack as I was aware of the
context in this case :)

Tony
