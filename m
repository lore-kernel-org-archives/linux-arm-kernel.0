From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 30 Jul 2014 14:21:16 +0200
Subject: [PATCHv7 1/5] mmc: dw_mmc: modify the dt-binding for removing
 slot-node and supports-highspeed
In-Reply-To: <1406514579-3769-2-git-send-email-jh80.chung@samsung.com>
References: <1406514579-3769-1-git-send-email-jh80.chung@samsung.com>
 <1406514579-3769-2-git-send-email-jh80.chung@samsung.com>
Message-ID: <53D8E33C.1010804@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.07.2014 04:29, schrieb Jaehoon Chung:
> Almost SoCs use one slot per host controller.

Still has "Almost SoCs" - I had suggested to insert "all", but I think
you mean "Most SoCs".

> (Even if controller can support the multiple slot, Recommend to use one slot per host controller.)
> Don't use the slot-node and deprecate the "supports-highspeed" property.
> Instead, use the cap-mmc/sd-highspeed.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
