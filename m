From: svenkatr@ti.com (S, Venkatraman)
Date: Mon, 23 Jul 2012 21:11:40 +0530
Subject: [PATCH 12/25] mmc/omap_hsmmc: add a const qualifier
In-Reply-To: <1343034810-3386-13-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-13-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CANfBPZ-5Jqy3CmUg7Oqt58ZQNa1LwwfSO6BAXk7Zxi0gpSKe+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2012 at 2:43 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> This prepares *of_device_id.data becoming const. Without this change
> the following warning would occur:
>
>         drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
>         drivers/mmc/host/omap_hsmmc.c:1808: warning: initialization discards qualifiers from pointer target type
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Venkatraman S <svenkatr@ti.com>


> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
