From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 27 Jun 2014 14:55:15 +0200
Subject: [PATCH v2 2/2] usb: chipidea: Add support for zynq usb host and
 device controller
In-Reply-To: <fa656d2d-a2a8-4b8d-a29b-e89e4bfced3e@BL2FFO11FD034.protection.gbl>
References: <1403868233-5123-1-git-send-email-punnaia@xilinx.com>
 <fa656d2d-a2a8-4b8d-a29b-e89e4bfced3e@BL2FFO11FD034.protection.gbl>
Message-ID: <20140627125515.GA6025@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 27, 2014 at 04:53:53PM +0530, Punnaiah Choudary Kalluri wrote:
> Zynq soc uses Chipidea/Synopsys usb IP core(CI13612). This patch adds
> necessary glue to allow the chipidea driver to work on zynq soc.
> 

Did you see the currently discussed patches for the generic chipidea
glue?

http://www.spinics.net/lists/linux-usb/msg109576.html

Try to improve that code instead writing another version
of this simple gluecode.


Thanks,
Michael


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
