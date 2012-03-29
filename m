From: b32955@freescale.com (Huang Shijie)
Date: Thu, 29 Mar 2012 10:45:26 +0800
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
Message-ID: <4F73CCC6.6000001@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
>  include/linux/stmp_device.h |   20 +++++++++++
IMHO, this header should be placed at include/linux/fsl/.
But the patch "mxs-dma : move the mxs dma.h to a more common place" is
still in the l2-mtd tree, not pushed
to upstream. :(

BR
Huang Shijie
