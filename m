From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 31 Jul 2010 11:05:16 +0900
Subject: [PATCH] S5V310: I2C0/I2C1/I2C2 support
In-Reply-To: <20100730105535.GA15067@july>
References: <20100730105535.GA15067@july>
Message-ID: <002f01cb3054$d4ea6bb0$7ebf4310$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Configure proper mux pins and define i2c0/i2c1/i2c2.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-s5pv310/Kconfig      |   10 ++++++++++
>  arch/arm/mach-s5pv310/Makefile     |    5 +++++
>  arch/arm/mach-s5pv310/setup-i2c0.c |   12 ++++++++++--
>  arch/arm/mach-s5pv310/setup-i2c1.c |   25 +++++++++++++++++++++++++
>  arch/arm/mach-s5pv310/setup-i2c2.c |   26 ++++++++++++++++++++++++++
>  5 files changed, 76 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c1.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c2.c
> 

(snip)

> +#include <mach/gpio.h>
Should be <linux/gpio.h>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
