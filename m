From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 6 Jan 2017 14:16:05 +0200
Subject: [PATCH v4 4/5] input: tm2-touchkey: Add touchkey driver support
 for TM2
In-Reply-To: <20170106114114.19321-5-andi.shyti@samsung.com>
References: <20170106114114.19321-1-andi.shyti@samsung.com>
 <CGME20170106114120epcas5p26f09370d63026c8fbb64df049d2e2cfd@epcas5p2.samsung.com>
 <20170106114114.19321-5-andi.shyti@samsung.com>
Message-ID: <20170106121605.dvq6kaacqouqecqe@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 08:41:13PM +0900, Andi Shyti wrote:
> From: Jaechul Lee <jcsing.lee@samsung.com>
> 
> This patch adds support for the TM2 touch key and led
> functionality.
> 
> The driver interfaces with userspace through an input device and
> reports KEY_PHONE and KEY_BACK event types. LED brightness can be
> controlled by "/sys/class/leds/tm2-touchkey/brightness".
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig        |  11 ++
>  drivers/input/keyboard/Makefile       |   1 +
>  drivers/input/keyboard/tm2-touchkey.c | 280 ++++++++++++++++++++++++++++++++++
>  3 files changed, 292 insertions(+)
>  create mode 100644 drivers/input/keyboard/tm2-touchkey.c
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
