From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 23 Jun 2016 19:40:05 +0900
Subject: [PATCH] extcon: Check for incorrect connection type in notifier
 register
In-Reply-To: <20160623075324.21935-1-stephen.boyd@linaro.org>
References: <CGME20160623075352epcas1p2eb3ffb26777a8aa253eade67b1fed827@epcas1p2.samsung.com>
 <20160623075324.21935-1-stephen.boyd@linaro.org>
Message-ID: <576BBC85.5070306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2016? 06? 23? 16:53, Stephen Boyd wrote:
> If we call extcon_register_notifier() with the wrong cable type,
> it blows up with an oops instead of returning an error code.
> Let's be nice and fail gracefully given that the consumer might
> not know if the cable is supported by the extcon provider.
> 
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  drivers/extcon/extcon.c | 4 ++++
>  1 file changed, 4 insertions(+)

This patch has some merge conflict because the base branch is not on linux-next.
But, Looks good to me. I applied it manually on extcon-next branch.

Thanks,
Chanwoo Choi
