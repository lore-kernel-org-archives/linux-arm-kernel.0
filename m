From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 22 Dec 2016 14:14:51 +0800
Subject: [PATCH 1/3] dma: zx: rename zx296702_dma.c to zx_dma.c
In-Reply-To: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
References: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
Message-ID: <CABymUCMU2cO_Fagin1MyHVfycNByFXw2baZo2ZUopYVx_-_BVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-15 22:03 GMT+08:00 Shawn Guo <shawnguo@kernel.org>:
> From: Shawn Guo <shawn.guo@linaro.org>
>
> ZTE ZX dma driver is not ZX296702 specific.  It works for not only
> ZX296702 but also other ZTE ZX family platforms like ZX296718.  Let's
> rename the file to reflect that.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/dma/Kconfig                      | 4 ++--
>  drivers/dma/Makefile                     | 2 +-
>  drivers/dma/{zx296702_dma.c => zx_dma.c} | 0
>  3 files changed, 3 insertions(+), 3 deletions(-)
>  rename drivers/dma/{zx296702_dma.c => zx_dma.c} (100%)
>
Reviewed-by:  Jun Nie <jun.nie@linaro.org>
