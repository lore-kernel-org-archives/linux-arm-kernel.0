From: jbe@pengutronix.de (Juergen Beisert)
Date: Fri, 16 Oct 2009 09:41:38 +0200
Subject: S3C2440: SD-Card access fails
In-Reply-To: <20091016054856.GB2261@trinity.fluff.org>
References: <200910152014.50677.jbe@pengutronix.de>
	<20091016054856.GB2261@trinity.fluff.org>
Message-ID: <200910160941.39181.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Freitag, 16. Oktober 2009, Ben Dooks wrote:
> On Thu, Oct 15, 2009 at 08:14:50PM +0200, Juergen Beisert wrote:
> > I'm using an S3C2440 based custom made board with a 2.6.31.3 kernel (with
> > a few modifications to add the boards specific file). When I do some
> > traffic on the SD card (1GiB SD type), for example untaring an archive I
> > get a failure like this one:
>
> Is your platform data marked __initdata?

Thanks for your answer. Yes, my local s3c24xx_mci_pdata structure was marked 
with __initdata, like the one in mach-s3c2440/mach-mini2440.c (seems I used 
the wrong example to create my own sources...).
I removed this __initdata marker in my sources and now SD card access seems to 
work (tests are still running).

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
