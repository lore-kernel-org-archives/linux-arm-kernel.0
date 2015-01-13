From: joe@perches.com (Joe Perches)
Date: Mon, 12 Jan 2015 18:42:42 -0800
Subject: [PATCH v4 1/2] watchdog: Add driver for Mediatek watchdog
In-Reply-To: <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
References: <1421076884-15860-1-git-send-email-matthias.bgg@gmail.com>
 <1421076884-15860-2-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1421116962.9233.17.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-01-12 at 16:34 +0100, Matthias Brugger wrote:
> This patch adds a driver for the Mediatek SoC integrated
> watchdog. This driver supports watchdog and software reset
> for mt65xx and mt81xx SoCs.

trivia:

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
[]
> +static int mtk_wdt_probe(struct platform_device *pdev)
> +{
[]
> +	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",

missing terminating \n newline
