From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 8 Feb 2016 11:40:15 +0100
Subject: [PATCH v2 04/10] ARM64: dts: rockchip: Add GMAC to GeekBox
In-Reply-To: <5875277.Y7zJ7W9GkY@phil>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
 <1454897859-7601-5-git-send-email-afaerber@suse.de> <5875277.Y7zJ7W9GkY@phil>
Message-ID: <56B8708F.50802@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Am 08.02.2016 um 11:28 schrieb Heiko Stuebner:
> Am Montag, 8. Februar 2016, 03:17:33 schrieb Andreas F?rber:
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> 
> is there some special reason that gmac, emmc, ir, etc are in separate 
> patches? I guess I'll just fold them into the core patch otherwise.

Yes, feel free to squash. They are separate because they were not in v1,
it makes them easier to review and I didn't want errors in them to hold
up the base .dts. :) For example, SDIO I am still fighting with.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
