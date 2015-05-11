From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 May 2015 21:24:27 +0200
Subject: [PATCH v2] Mediatek SCPSYS power domain support
In-Reply-To: <2471388.4xC5mv0cE3@ubix>
References: <1431349882-12260-1-git-send-email-s.hauer@pengutronix.de>
 <2471388.4xC5mv0cE3@ubix>
Message-ID: <20150511192427.GM6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 06:05:20PM +0200, Matthias Brugger_0 wrote:
> On Monday, May 11, 2015 03:11:18 PM Sascha Hauer wrote:
> > This series adds support for the MediaTek SCPSYS unit.
> > 
> > The SCPSYS unit handles several power management related tasks such
> > as thermal measurement, DVFS, interrupt filter and low level sleep
> > control.
> > 
> > The initial support only contains the generic power domain handling.
> > This is needed to turn on power to the different power domains.
> > 
> > The driver is quite straight forward now. Due to the lack of a better
> > place I have put it to drivers/soc/mediatek. As the SCPSYS unit has
> > several other tasks that also do not fit into some specific subsystem
> > this probably is a good place for this driver.
> > 
> > Please review, any input welcome.
> > 
> > Sascha
> > 
> > changes since v1:
> > - make MFG_ASYNC a subdomain of MFG_2D and MFG_2D a subdomain of MFG
> > - Add (now hopefully properly) infracfg register handling again
> > - Add clock handling
> > - Fix on/off mixup in error message
> > - Make readonly data const
> > - Fix MODULE_LICENSE to GPL v2
> 
> I can't find this changes. It looks like you send the wrong patches. 
> Please resend.

Damn, I just proved that changelogs are useful ;)
I have just resent this series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
