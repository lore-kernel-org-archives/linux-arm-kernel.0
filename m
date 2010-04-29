From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 29 Apr 2010 08:47:33 +0300
Subject: [PATCH] pxa32xx_nand: add support for partition table parsing
In-Reply-To: <1272057944-19380-1-git-send-email-mkl@pengutronix.de>
References: <1272057944-19380-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1272520053.7750.71.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-04-23 at 23:25 +0200, Marc Kleine-Budde wrote:
> The pxa32xx_nand driver doesn't support partition tables from the
> command line. This patch adds support for it.
> 
> Please review and consider to apply.
> 
> cheers, Marc
> 
> 
> From a2caa92b08351511ee60bd94bf735be5f3a6fb65 Mon Sep 17 00:00:00 2001
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Fri, 23 Apr 2010 10:43:42 +0200
> Subject: [PATCH] pxa32xx_nand: add support for partition table parsing
> 
> The pxa32xx_nand driver doesn't support partition tables from the
> command line. This patch adds support for it.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Taken to l2-mtd-2.6.git / master.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
