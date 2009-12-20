From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun, 20 Dec 2009 14:14:22 +0100
Subject: Using SD cards on Samsung S3C2410/S3C2440 based systems
In-Reply-To: <4B2E2058.5070604@warmcat.com>
References: <200912151443.59761.jbe@pengutronix.de>
	<200912201322.23013.jbe@pengutronix.de>
	<4B2E2058.5070604@warmcat.com>
Message-ID: <200912201414.23560.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On Sonntag, 20. Dezember 2009, Andy Green wrote:
> > Yes, all signals except the clock are pulled up to +5V (10K), and a small
> > cap to ground (don't know their values yet).
>
> Actually, they shouldn't be pulled up to your SD Card power rail.
>
> If 5V IS your SD Card power rail, I have some bad news for you...

Ups, sorry, my fault. The pullups are connected to 3.3V. The SD card power is 
also 3.3V (I was confused, because there is also 5V at the main board 
connector, but not connected to the any SD related parts).

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
