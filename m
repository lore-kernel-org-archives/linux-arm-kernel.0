From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Mon, 21 Nov 2016 12:00:11 +0100
Subject: serial: imx: regression triggered by newly introduced DSR irq
 handling
In-Reply-To: <20160805065845.GI17874@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
Message-ID: <1479726011.2807.11.camel@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Uwe

On Fri, 2016-08-05 at 08:58 +0200, Uwe Kleine-K?nig wrote:
> Once this is done (and still an issue)

Yes, patch b5ca028fe9ba2090a (ARM: dts: imx6sx: document SION necessity
of ENET1_REF_CLK1) is done and mainline and DSR irq handling is still an
issue.

>  I'd suggest to standardize a dt
> property
> 
> 	disable-dsr;

Would you go forward?

> (and the same for the other handshaking lines) and support th{is,ese} in
> the imx uart driver. Reverting 27e16501052e IMO isn't a sensible option.

Okay, I'm fine with a 'disable-dsr' solution.

Thanks
  -- Christoph
