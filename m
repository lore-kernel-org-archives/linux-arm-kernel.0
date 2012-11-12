From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Mon, 12 Nov 2012 08:54:11 +0100
Subject: usb clock not found on imx27 when using dt
In-Reply-To: <1352666074.32152.YahooMailNeo@web28806.mail.ir2.yahoo.com>
References: <1352666074.32152.YahooMailNeo@web28806.mail.ir2.yahoo.com>
Message-ID: <20121112075411.GO10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 11, 2012 at 08:34:34PM +0000, Philippe Reynes wrote:
> Hi all,
> 
> I try to add the support of usb on my armadeus apf27,
> but there is a problem when try to reclaim the clock.
> imx_usb mxc-ehci.0: Failed to get clock, err=-2
> 
> To avoid adding too many attachment to this mail,
> I've put all the information on a website. You can
> found them here:? http://ryu.zarb.org/~trem/armadeus/
> 
> 
> The initial issue is in the directory : 20121110
> 
> boot-3.7-rc4.log : boot log with the issue
> linux-3.7-rc4.config : the configuration file for the kernel
> investifation.txt : the description of my investigation.

You should really post the relevant bits on the mailing list. Nobody
visits websites for investigating your issue. Besides, it will not be
in the mailing list archives so people will not find it later.

> 
> 
> I've tried to fix the clock issue, but another issue occurs.
> The information about this "fix" is in : 20121111
> boot-3.7-rc4.log : boot log with the new issue
> issue.txt : the description of the change done on the kernel
> 
> I've got severals questions :
> - does my dts correct with usb change ?
> - does someone has already tested usb on imx27 with dt ?

Please investigate in using the chipidea driver. This will be the way
forward for i.MX.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
