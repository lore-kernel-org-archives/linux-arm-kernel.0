From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 28 Jun 2014 13:46:43 +0800
Subject: [PATCH v2 2/2] usb: chipidea: Add support for zynq usb host
 and device controller
In-Reply-To: <20140627125515.GA6025@pengutronix.de>
References: <1403868233-5123-1-git-send-email-punnaia@xilinx.com>
 <fa656d2d-a2a8-4b8d-a29b-e89e4bfced3e@BL2FFO11FD034.protection.gbl>
 <20140627125515.GA6025@pengutronix.de>
Message-ID: <20140628054641.GA14192@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 02:55:15PM +0200, Michael Grzeschik wrote:
> Hi,
> 
> On Fri, Jun 27, 2014 at 04:53:53PM +0530, Punnaiah Choudary Kalluri wrote:
> > Zynq soc uses Chipidea/Synopsys usb IP core(CI13612). This patch adds
> > necessary glue to allow the chipidea driver to work on zynq soc.
> > 
> 
> Did you see the currently discussed patches for the generic chipidea
> glue?
> 
> http://www.spinics.net/lists/linux-usb/msg109576.html
> 
> Try to improve that code instead writing another version
> of this simple gluecode.
> 

+1 if you think your version can be covered by generic one.

-- 

Best Regards,
Peter Chen
