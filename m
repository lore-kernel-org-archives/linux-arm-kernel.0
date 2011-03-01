From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 1 Mar 2011 09:34:15 +0100
Subject: [PATCH] plat-mxc: Provide irq_chip name for GPIO IRQs
In-Reply-To: <201103010838.37197.alexander.stein@systec-electronic.com>
References: <1296489624-21355-1-git-send-email-alexander.stein@systec-electronic.com>
	<201103010838.37197.alexander.stein@systec-electronic.com>
Message-ID: <20110301083415.GA2212@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >  static struct irq_chip gpio_irq_chip = {
> > +	.name = "GPIO",

I'd suggest a more specific name, e.g. "i.MX GPIO"? You can then also
add my

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110301/dacba0d6/attachment.sig>
