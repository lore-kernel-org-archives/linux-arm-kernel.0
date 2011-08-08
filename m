From: b32955@freescale.com (Huang Shijie)
Date: Mon, 8 Aug 2011 17:12:46 +0800
Subject: GPMI-NAND Status?
In-Reply-To: <20110805135133.GA26981@pengutronix.de>
References: <20110805135133.GA26981@pengutronix.de>
Message-ID: <4E3FA88E.4070804@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
>
> ecclayout needs to be used to show that OOB is fully in use [1]
> ===============================================================
>
> Needed to make it work for JFFS2 and to pass the mtd-testsuite. A driver only
> working with UBIFS is surely not ready for mainline.
>
It seems just modifying the ecclayout of GPMI-NAND can not fix the problem.
It should also change the code of JFFS2 and mtd.

Some one ever posted a patch about this:
http://lists.infradead.org/pipermail/linux-mtd/2007-December/020047.html

Best Regards
Huang Shijie
