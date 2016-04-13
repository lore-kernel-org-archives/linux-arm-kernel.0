From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Wed, 13 Apr 2016 11:13:36 +0200
Subject: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
In-Reply-To: <20160412173032.GS10108@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160411160128.GD26941@ibawizard.net>
 <20160412074622.GQ10108@pengutronix.de>
 <20160412094846.GF26941@ibawizard.net>
 <20160412105856.GR10108@pengutronix.de>
 <20160412121759.GG26941@ibawizard.net>
 <20160412173032.GS10108@pengutronix.de>
Message-ID: <20160413091336.GH26941@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [2016-04-12 19:30:32]:

> On Tue, Apr 12, 2016 at 02:17:59PM +0200, Petr ?tetiar wrote:
> > Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [2016-04-12 12:58:56]:
> > 
> > > ok, so UFCR_DCEDTE is set and UCR3_DSR controls the DTR output as
> > > intended. What is connected to the respective pin?
> > > MX6QDL_PAD_EIM_D25__UART1_DSR_B I think is the one.
> > 
> > It's routed out to Apalis SoM pin 120, which is then connected via 22R
> > resistor and through SN65C3243DBR RS-232 line driver to header which I use as
> > debug/serial console.
> 
> Then I guess the problem is that the rs232-partner asserts the imx6's
> DSR in reply to the imx6 asserting DTR?

Yes, that's correct.

-- ynezz
