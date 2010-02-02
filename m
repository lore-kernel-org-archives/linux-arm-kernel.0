From: chetannanda@gmail.com (Chetan Nanda)
Date: Tue, 2 Feb 2010 14:11:29 +0530
Subject: not able to understand 'icedcc_putc'
In-Reply-To: <20100202083353.GA22848@pengutronix.de>
References: <7f245da81001290848n5630c6b6q68f19369fd0ad5aa@mail.gmail.com>
	<20100202083353.GA22848@pengutronix.de>
Message-ID: <7f245da81002020041v7b020284q4540118547d601ab@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/2/2 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> Hello,
>
> On Fri, Jan 29, 2010 at 10:18:55PM +0530, Chetan Nanda wrote:
> > Hello,
> >
> > I am newbie to ARM core. This might be a very silly question, but I am
> not
> > able to understand how 'icedcc_putc' function prints a character on
> console
> > (UART).
> It doesn't, so no wonder you don't see how it does.
>
> icedcc_putc uses the debug communications channel.  You can read it via
> jtag.
>
> If you want to understand the output on the serial console, you have to
> look into <mach/uncompress.h>.
>
> Yhea, on closely looking at code I was able to figure out the code.

~cnanda

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                              | Uwe Kleine-K?nig
>  |
> Industrial Linux Solutions                    | http://www.pengutronix.de/ |
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100202/e464808c/attachment-0001.htm>
