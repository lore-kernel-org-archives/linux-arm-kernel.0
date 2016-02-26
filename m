From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 26 Feb 2016 19:06:29 +0900
Subject: [PATCH 31/50] pinctrl: uniphier: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-32-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-32-git-send-email-ldewangan@nvidia.com>
Message-ID: <CAK7LNATP6vBz3CvD5cJ+DwbL3g8e_UJ40W8zZJwzQrKXnWokkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-24 22:15 GMT+09:00 Laxman Dewangan <ldewangan@nvidia.com>:
> Use devm_pinctrl_register() for pin control registration and remove
> need of .remove callback.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks!



-- 
Best Regards
Masahiro Yamada
