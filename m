From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 13 Jul 2015 21:06:22 +0200 (CEST)
Subject: [PATCH v7 2/9] nvmem: Add a simple NVMEM framework for consumers
In-Reply-To: <1436521495-10728-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1436521427-10568-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1436521495-10728-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1510509759.163664.1436814382477.JavaMail.open-xchange@oxbsltgw06.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> hat am 10. Juli 2015 um
> 11:44 geschrieben:
>
>
> [...]
> ---
> drivers/nvmem/core.c | 424 ++++++++++++++++++++++++++++++++++++++++-
> include/linux/nvmem-consumer.h | 76 ++++++++
> 2 files changed, 498 insertions(+), 2 deletions(-)
> create mode 100644 include/linux/nvmem-consumer.h
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index a779ad1..f429ad4 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -15,14 +15,15 @@
> */
>
> #include <linux/device.h>
> -#include <linux/nvmem-provider.h>
> #include <linux/export.h>
> #include <linux/fs.h>
> #include <linux/idr.h>
> #include <linux/init.h>
> -#include <linux/regmap.h>

please avoid such changes in your patch series. This should be fixed in the
first patch.

Thanks
Stefan
