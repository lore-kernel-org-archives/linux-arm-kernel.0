From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Jul 2013 18:35:26 +0300
Subject: [PATCH v2 8/9] wlcore: sdio: get clocks from device tree
In-Reply-To: <1372776948-24840-9-git-send-email-coelho@ti.com>
References: <1372776948-24840-1-git-send-email-coelho@ti.com>
 <1372776948-24840-9-git-send-email-coelho@ti.com>
Message-ID: <20130702153526.GI7013@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 02, 2013 at 05:55:47PM +0300, Luciano Coelho wrote:
> @@ -294,6 +316,8 @@ static int wl1271_probe(struct sdio_func *func,
>  	/* Use block mode for transferring over one block size of data */
>  	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
>  
> +	sdio_set_drvdata(func, glue);

is this move really necessary ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130702/a7cd1015/attachment.sig>
