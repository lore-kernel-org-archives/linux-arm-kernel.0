From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 20:34:16 +0800
Subject: [MXS MMC 5/5] Add an appropriate MODULE_ALIAS
In-Reply-To: <b1c45bfdbc9323b2a6c50ce213a3e895aeea2b2f.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <b1c45bfdbc9323b2a6c50ce213a3e895aeea2b2f.1323177907.git.LW@KARO-electronics.de>
Message-ID: <20111207123415.GO5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 02:41:30PM +0100, Lothar Wa?mann wrote:
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/mmc/host/mxs-mmc.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 0003d03..1ba08ae 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -886,3 +886,4 @@ module_exit(mxs_mmc_exit);
>  MODULE_DESCRIPTION("FREESCALE MXS MMC peripheral");
>  MODULE_AUTHOR("Freescale Semiconductor");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mxs-mmc");

Acked-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
