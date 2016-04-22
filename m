From: adrian.hunter@intel.com (Adrian Hunter)
Date: Fri, 22 Apr 2016 13:28:06 +0300
Subject: [PATCH 03/23] mmc: core: fix a comment typo
In-Reply-To: <1460741387-23815-4-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <5719FCB6.6010601@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 20:29, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

I'll leave this one up to Ulf.

> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 62355bd..d220bbd 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -553,7 +553,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  
>  		/*
>  		 * We are not allowed to issue a status command and the host
> -		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
> +		 * doesn't support MMC_CAP_WAIT_WHILE_BUSY, then we can only
>  		 * rely on waiting for the stated timeout to be sufficient.
>  		 */
>  		if (!send_status) {
> 
