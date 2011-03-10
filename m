From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Mar 2011 15:37:20 +0100
Subject: i.MX Pull request for -next
In-Reply-To: <20110310135440.GE11273@n2100.arm.linux.org.uk>
References: <20110310134412.GD29521@pengutronix.de>
	<20110310135440.GE11273@n2100.arm.linux.org.uk>
Message-ID: <20110310143720.GE29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 01:54:40PM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 10, 2011 at 02:44:13PM +0100, Sascha Hauer wrote:
> > Hi Russell,
> > 
> > please pull the following for the next merge window.
> 
> Please can you provide a summary of these changes for me to include in
> my eventual pull request to Linus?
> 

Sure. Is this enough?

This branch contains the collected Freescale i.MX related updates.

- additions of board glue code for new devices
- A bunch of unnecessary ifdef removal
- Add a full description of iomux settings for i.MX53

new boards:
- Efika Smartbook
- VPR200
- Ka-Ro TX28
- Eukrea MBIMXSD51
- IMX27IPCAM

new drivers:
- Freescale i.MX23/28 AUART driver,
- Freescale i.MX23/28 framebuffer driver


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
