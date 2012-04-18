From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Wed, 18 Apr 2012 17:05:52 +0800
Subject: [PATCH V2 1/3] lib: add support for stmp-style devices
In-Reply-To: <20120329064320.GA20840@pengutronix.de>
References: <1332368519-22660-1-git-send-email-w.sang@pengutronix.de>
 <1332368519-22660-2-git-send-email-w.sang@pengutronix.de>
 <4F73CCC6.6000001@freescale.com>
 <20120329064320.GA20840@pengutronix.de>
Message-ID: <20120418090551.GA30966@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Thu, Mar 29, 2012 at 08:43:20AM +0200, Wolfram Sang wrote:
> Hi,
> 
> > >  include/linux/stmp_device.h |   20 +++++++++++
> > IMHO, this header should be placed at include/linux/fsl/.
> 
> Hmm, one never knows if somewhen in the future some other vendor decides to do
> do a device with this register layout. It is just a layout, not an IP core per
> se. So, I'd prefer to leave it as is.
> 

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

I'm converting mxs-dma driver to be mach-independent which also needs
this patch.

Do you know when this will be merged?

BTW, one small question:
Is it possible that stmp_reset_block also be used by other vendors?
If not, i guess include/linux/fsl which already exists may be the
right place.

Regards
Dong Aisheng
