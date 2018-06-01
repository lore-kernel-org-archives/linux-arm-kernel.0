From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 1 Jun 2018 11:35:19 +0200
Subject: [PATCH 2/4] thermal: bcm2835: Stop using printk format %pCr
In-Reply-To: <1527845302-12159-3-git-send-email-geert+renesas@glider.be>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <1527845302-12159-3-git-send-email-geert+renesas@glider.be>
Message-ID: <49541212-0bf7-06ec-7a3d-f01f7b658481@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 01.06.2018 um 11:28 schrieb Geert Uytterhoeven:
> Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
> called in atomic context.
>
> Replace it by printing the variable that already holds the clock rate.
> Note that calling clk_get_rate() is safe here, as the code runs in task
> context.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks
