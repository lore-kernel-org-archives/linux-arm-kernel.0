From: mgr@pengutronix.de (Michael Grzeschik)
Date: Thu, 7 Mar 2013 23:54:03 +0100
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
 <20121128025217.GC18593@nchen-desktop>
 <87ip6mor1e.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130307225403.GI29785@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Alex,

On Thu, Jan 24, 2013 at 11:42:53AM +0200, Alexander Shishkin wrote:
> Peter Chen <peter.chen@freescale.com> writes:
> 
> > On Tue, Nov 27, 2012 at 05:16:55PM +0100, Michael Grzeschik wrote:
> >> Nearly every SoC from Freescale has this non-core usb registers. This series
> >> adds support for more users of this driver.
> >> 
> >> This series is based on Peter Chen's work. Its needed to merge his master branch
> >> before applying this series:
> >> 
> >> https://github.com/hzpeterchen/linux-usb.git
> >
> > I have tested it at i.mx6q sabrelite board, it works good.
> >
> > I have pushed your commit to my git, please cc me
> > your coming chipidea patches, thanks.
> >
> > Alex, please add:
> >
> > Reviewed-by: Peter Chen <peter.chen@freescale.com>
> > Tested-by: Peter Chen <peter.chen@freescale.com>
> 
> Looks good, queueing this one for submission.

Now that you have your git-tree [1], could you queue that for
submission?

[1] git://github.com/virtuoso/linux-ci.git ci-for-greg

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
