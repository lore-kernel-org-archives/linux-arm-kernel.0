From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 3 Feb 2011 23:12:07 +0100
Subject: [PATCH v3 2/2] Input: ads7846: use gpio_request_one to
	configure pendown_gpio
In-Reply-To: <20110203171953.GA13997@core.coreip.homeip.net>
References: <1296746506-12221-1-git-send-email-sourav.poddar@ti.com>
	<20110203165405.GB12802@core.coreip.homeip.net>
	<20110203171953.GA13997@core.coreip.homeip.net>
Message-ID: <20110203221207.GA1437@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 03, 2011 at 09:19:53AM -0800, Dmitry Torokhov wrote:
> On Thu, Feb 03, 2011 at 08:54:05AM -0800, Dmitry Torokhov wrote:
> > On Thu, Feb 03, 2011 at 08:51:46PM +0530, Sourav Poddar wrote:
> > > The ads7846 driver requests a gpio but does not currently
> > > configure it explicitly as an input. Use gpio_request_one
> > > to request and configure it at one shot.
> > > 
> > > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> > > Cc: Dmitry Torokhov <dtor@mail.ru>
> > 
> > Will apply this one, the other one is a bit messy IMO, will have to
> > think about it.
> > 
> 
> Something like below should do I think.

Yeah, that was what I was suggesting, too

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110203/a68d36a8/attachment.sig>
