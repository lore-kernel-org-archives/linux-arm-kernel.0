From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 22 Sep 2018 22:11:41 +0200
Subject: [PATCH] soc: actions: Update SPS help text for S700
In-Reply-To: <20180624140108.13505-1-afaerber@suse.de>
References: <62ef1835-8db9-f1e8-53b9-4cd74b5d416d@suse.de>
 <20180624140108.13505-1-afaerber@suse.de>
Message-ID: <0a574d0f-a2c3-b714-61d5-c26b12beae51@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.06.18 um 16:01 schrieb Andreas F?rber:
> Commit 3ad85b08f7789d51e6aad0f535296d1c31e319b9 (soc: actions: sps: Add S700)
> added S700 support to the SPS driver but forget to update Kconfig help.
> 
> Add missing S700 mention, in preparation for further SoCs.
> 
> Fixes: 3ad85b08f778 ("soc: actions: sps: Add S700")
> Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  drivers/soc/actions/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to v4.20/drivers branch.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
