From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 7 Jul 2014 13:49:25 +0800
Subject: [PATCH] bus: imx-weim: populate devices on a simple bus
In-Reply-To: <1404464441-31755-1-git-send-email-Ying.Liu@freescale.com>
References: <1404464441-31755-1-git-send-email-Ying.Liu@freescale.com>
Message-ID: <20140707054923.GL30239@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 05:00:41PM +0800, Liu Ying wrote:
> There could be some memory map devices located in
> a certain chip select region of the i.MX WEIM.
> The devices could be attached to a simple bus(for
> example, a AXI bus) whose root node is one child
> device tree node of the i.MX WEIM device tree node.
> There should be a bridge(very likely, software
> transparent) bewteen the i.MX WEIM and the simple bus.
> This patch makes the i.MX WEIM driver possible to
> populate devices on a simple bus.  In this way, people
> may try various IPs(in a FPGA, maybe) outside of i.MX
> chips with the i.MX WEIM embedded.
> 
> Signed-off-by: Liu Ying <Ying.Liu@freescale.com>

Applied, thanks.
