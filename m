From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 11 Aug 2011 11:53:48 -0300
Subject: [PATCH v2 2/3] ARM: i.MX51: clean up iomux-mx51.h
In-Reply-To: <1313026292-945-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1313026292-945-1-git-send-email-troy.kisky@boundarydevices.com>
	<1313026292-945-2-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <CAOMZO5BiB1TFtgMLBUFcboHUXMUVaG4kkKVzW0vMt0SFuTmk4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Troy,

On Wed, Aug 10, 2011 at 10:31 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
...
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51.h b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> index df6acc0..c7f5169 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx51.h
> @@ -14,6 +14,8 @@
> ?#define __MACH_IOMUX_MX51_H__
>
> ?#include <mach/iomux-v3.h>
> +#define __NA_ ?0x000
> +

Do we really need this __NA_ define? Can?t we continue just writing 0
in the macro?

Regards,

Fabio Estevam
