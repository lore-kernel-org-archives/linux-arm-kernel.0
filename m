From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Jun 2017 11:01:36 +0200
Subject: [PATCH v2 1/2] tty/serial: atmel: remove
 atmel_default_console_device handling
In-Reply-To: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
References: <20170613202439.26369-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170623090136.mblnokm3f2twurwq@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 13, 2017 at 10:24:38PM +0200, Alexandre Belloni wrote:
> atmel_default_console_device was only used by AVR32, in particular
> arch/avr32/mach-at32ap/at32ap700x.c which is now gone. Remove it from the
> driver.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
I found the same change independently, but as you were there first:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
