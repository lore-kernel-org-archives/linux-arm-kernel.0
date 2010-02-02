From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Feb 2010 09:33:53 +0100
Subject: not able to understand 'icedcc_putc'
In-Reply-To: <7f245da81001290848n5630c6b6q68f19369fd0ad5aa@mail.gmail.com>
References: <7f245da81001290848n5630c6b6q68f19369fd0ad5aa@mail.gmail.com>
Message-ID: <20100202083353.GA22848@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Jan 29, 2010 at 10:18:55PM +0530, Chetan Nanda wrote:
> Hello,
> 
> I am newbie to ARM core. This might be a very silly question, but I am not
> able to understand how 'icedcc_putc' function prints a character on console
> (UART).
It doesn't, so no wonder you don't see how it does.

icedcc_putc uses the debug communications channel.  You can read it via
jtag.

If you want to understand the output on the serial console, you have to
look into <mach/uncompress.h>.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
