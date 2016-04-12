From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Apr 2016 14:15:08 -0700
Subject: [PATCH V2] ARM: dts: AM572x-IDK Initial Support
In-Reply-To: <20160328211015.GA28249@rob-hp-laptop>
References: <1459182909-23502-1-git-send-email-nm@ti.com>
 <20160328211015.GA28249@rob-hp-laptop>
Message-ID: <20160412211508.GF5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [160328 14:11]:
> On Mon, Mar 28, 2016 at 11:35:09AM -0500, Nishanth Menon wrote:
> > From: Schuyler Patton <spatton@ti.com>
> > 
> > The AM572x-IDK board is a board based on TI's AM5728 SOC
> > which has a dual core 1.5GHz A15 processor. This board is a
> > development platform for the Industrial market with:
> > - 2GB of DDR3L
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
> > http://www.ti.com/product/AM5728
> > 
> > This patch creates a common dtsi file that will provide a common board
> > dtsi file to define the nodes that are common to AM57xx (including the
> > upcoming AM5718) IDK boards.
> > 
> > Initial support is only for basic peripherals
> 
> Acked-by: Rob Herring <robh@kernel.org>

Applying into omap-for-v4.7/dt thanks.

Tony
