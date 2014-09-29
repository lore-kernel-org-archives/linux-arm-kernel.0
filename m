From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 29 Sep 2014 16:57:53 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <1a0ed130-a53d-42df-9f6a-994c5b68755c@BN1BFFO11FD031.protection.gbl>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
 <1a0ed130-a53d-42df-9f6a-994c5b68755c@BN1BFFO11FD031.protection.gbl>
Message-ID: <20140929145753.GC8912@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 04:58:14PM -0700, S?ren Brinkmann wrote:
> On Tue, 2014-09-23 at 12:28PM +0200, Antoine Tenart wrote:
> > Add a USB2 ChipIdea driver for ci13xxx, with optional PHY, clock
> > and DMA mask, to support USB2 ChipIdea controllers that don't need
> > specific functions.
> > 
> > Tested on the Marvell Berlin SoCs USB controllers.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 
> This driver also works for Zynq. I didn't do extensive testing, but I
> could access a flash drive successfully.
> 
> Tested-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
