From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 14:20:32 +0100
Subject: [PATCHv2 2/3] ASoC: s3c24xx-i2s: pass DMA channels as platform
 data
In-Reply-To: <4020501.kQLt6nnIEv@wuerfel>
References: <6346833.MfUC71I3uD@wuerfel> <4020501.kQLt6nnIEv@wuerfel>
Message-ID: <4029229.ZxVVfeA0q2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 16:54:16 Arnd Bergmann wrote:
> +#include <linux/platform_data/asoc-s3c.h.h>
> 

My randconfig test setup has now found the typo above. Resending the
fixed version.

	Arnd
