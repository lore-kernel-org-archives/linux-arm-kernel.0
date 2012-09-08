From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 08 Sep 2012 10:07:01 +0200
Subject: [PATCH] ARM: dts: exynos4: Enable serial controllers on Origen
 and SMDKV310
In-Reply-To: <24d901cd8d6a$c10c9710$4325c530$%kim@samsung.com>
References: <1346675674-16034-1-git-send-email-t.figa@samsung.com>
 <1808225.QZz0WEipT7@amdc1227>
 <24d901cd8d6a$c10c9710$4325c530$%kim@samsung.com>
Message-ID: <1448000.LeaitbqYWR@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Saturday 08 of September 2012 11:36:30 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > This patch adds status override of serial nodes to enable used serial
> > ports
> > on Origen and SMDKV310 board.
> 
> Well...I'm not sure about the status of Origen serial, but all of the
> serials are enabled on SMDKV310, is it right?

According to arrays of struct s3c2410_uartcfg in mach-origen.c and mach-
smdkv310.c, all the four serial ports are enabled on both boards.

--
Best regards,
Tomasz Figa
