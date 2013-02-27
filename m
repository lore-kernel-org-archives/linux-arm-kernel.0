From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 27 Feb 2013 16:13:14 +0800
Subject: [PATCH v10 6/8] usb: chipidea: imx: add internal vbus
 regulator control
In-Reply-To: <20130227080735.GH1906@pengutronix.de>
References: <1361946799-29471-1-git-send-email-peter.chen@freescale.com>
 <1361946799-29471-7-git-send-email-peter.chen@freescale.com>
 <20130227075510.GB8016@arwen.pp.htv.fi>
 <20130227080735.GH1906@pengutronix.de>
Message-ID: <20130227081313.GI20402@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 27, 2013 at 09:07:35AM +0100, Sascha Hauer wrote:
> On Wed, Feb 27, 2013 at 09:55:10AM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Wed, Feb 27, 2013 at 02:33:17PM +0800, Peter Chen wrote:
> > > - For host, the vbus should always be on.
> > > - For otg, the vbus is off defaultly, the vbus needs to be
> > > turned on/off when usb role switches.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > 
> > one quick question, if chipidea already has an imx glue layer, can I
> > delete the broken imx_udc ? It doesn't even compile and it's including
> > headers which don't exist.
> 
> This driver handles i.MX1. This one has a gadget only core which is not
> chipidea compatible. You should ping Darius Augulis <augulis.darius@gmail.com>
> if he is willing to put some love into the driver.

Sascha is correct.

-- 

Best Regards,
Peter Chen
