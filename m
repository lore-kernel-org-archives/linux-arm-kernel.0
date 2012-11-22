From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 22 Nov 2012 17:31:44 +0800
Subject: [PATCH v3 0/7] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <87y5hu3s83.fsf@ashishki-desk.ger.corp.intel.com>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
 <87y5hu3s83.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20121122093143.GA22420@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 11:24:44AM +0200, Alexander Shishkin wrote:
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
> > Nearly every SoC from Freescale has this non-core usb registers. This series
> > adds support for more users of this driver.
> >
> > This series is based on Peter Chen's work. Its needed to merge his master branch
> > before applying this series:
> >
> > https://github.com/hzpeterchen/linux-usb.git
> >
> > Marc Kleine-Budde (4):
> >   usb: chipidea: usbmisc: unset global varibale usbmisc on driver
> >     remove
> >   usb: chipidea: usbmisc: fix a potential race condition
> >   usb: chipidea: usbmisc: prepare driver to handle more than one soc
> >   usb: chipidea: usbmisc: add support for ahb, ipg and per clock
> >
> > Michael Grzeschik (3):
> >   usb: chipidea: usbmisc: rename file, struct and functions to
> >     usbmisc_imx
> >   usb: chipidea: usbmisc: add mx53 support
> >   usb: chipidea: usbmisc: add post handling and errata fix for mx25
> 
> Cc'ing Peter Chen, in case he didn't see this. Peter, can you have a
> look and give your Tested-by/Reviewed-by where appropriate?

OK, I will have a look tomorrow or the beginning of next week.
> 
> Regards,
> --
> Alex
> 

-- 

Best Regards,
Peter Chen
