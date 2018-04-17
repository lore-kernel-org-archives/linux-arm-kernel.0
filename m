From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 17 Apr 2018 11:14:22 +0900
Subject: [PATCH v2 2/2] pinctrl/samsung: Document required order of banks
In-Reply-To: <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CA+Ln22Hgn5VmeUAdcmHi64-HdRqpuGBBN9uUzmFTOBatagzXeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-17 0:52 GMT+09:00 Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>:
> This patch documents requirement coming from the way
> exynos_eint_gpio_irq() is working now, which expects
> EINTG banks to be at the beginning of the bank arrays.
>
> Cc: stable at vger.kernel.org

Probably no need for this one to go to stable, but either is fine for me.

> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 26 ++++++++++++++++++++++++++
>  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 ++++++++++++++++++++
>  2 files changed, 46 insertions(+)

Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks for the patch!

Best regards,
Tomasz
