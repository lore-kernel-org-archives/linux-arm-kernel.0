From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 25 Feb 2016 15:00:04 +0100
Subject: [PATCH 27/50] pinctrl: stm32: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-28-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-28-git-send-email-ldewangan@nvidia.com>
Message-ID: <CALszF6Bq4gK1bOJFVE3VAWjnX9eYpQeEVVO-_g2kv0O=iePJyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-02-24 14:15 GMT+01:00 Laxman Dewangan <ldewangan@nvidia.com>:
> Use devm_pinctrl_register() for pin control registration.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> ---
>  drivers/pinctrl/stm32/pinctrl-stm32.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Thanks!
Maxime
