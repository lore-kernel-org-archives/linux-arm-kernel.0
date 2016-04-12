From: ynezz@true.cz (Petr =?iso-8859-2?Q?=A9tetiar?=)
Date: Tue, 12 Apr 2016 14:17:59 +0200
Subject: [PATCH v2 0/6] serial: imx: handshaking fixes and improvments
In-Reply-To: <20160412105856.GR10108@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160411160128.GD26941@ibawizard.net>
 <20160412074622.GQ10108@pengutronix.de>
 <20160412094846.GF26941@ibawizard.net>
 <20160412105856.GR10108@pengutronix.de>
Message-ID: <20160412121759.GG26941@ibawizard.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [2016-04-12 12:58:56]:

> ok, so UFCR_DCEDTE is set and UCR3_DSR controls the DTR output as
> intended. What is connected to the respective pin?
> MX6QDL_PAD_EIM_D25__UART1_DSR_B I think is the one.

It's routed out to Apalis SoM pin 120, which is then connected via 22R
resistor and through SN65C3243DBR RS-232 line driver to header which I use as
debug/serial console.

-- ynezz
