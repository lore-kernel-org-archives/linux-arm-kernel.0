From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 21 Nov 2016 12:07:13 +0100
Subject: serial: imx: regression triggered by newly introduced DSR irq
 handling
In-Reply-To: <1479726011.2807.11.camel@googlemail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1479726011.2807.11.camel@googlemail.com>
Message-ID: <20161121110713.prjwxrvh66bztvbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Christoph,

On Mon, Nov 21, 2016 at 12:00:11PM +0100, Christoph Fritz wrote:
> On Fri, 2016-08-05 at 08:58 +0200, Uwe Kleine-K?nig wrote:
> > Once this is done (and still an issue)
> 
> Yes, patch b5ca028fe9ba2090a (ARM: dts: imx6sx: document SION necessity
> of ENET1_REF_CLK1) is done and mainline and DSR irq handling is still an
> issue.
> 
> >  I'd suggest to standardize a dt
> > property
> > 
> > 	disable-dsr;
> 
> Would you go forward?

Currently I don't have the need and time to do this myself. So if you
want to propose a patch and send if for review to the dt and serial MLs
that would be a good next step. If you add me to Cc (or To) I can take a
look.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
