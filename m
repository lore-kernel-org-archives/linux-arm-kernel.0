From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Nov 2016 11:22:42 -0300
Subject: [PATCH 1/6] mfd: max8997: Initialize max8997 register map
In-Reply-To: <1478513376-14307-2-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
 <1478513376-14307-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1b150578-b766-3470-475c-fe494bcc8c54@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On 11/07/2016 07:09 AM, Pankaj Dubey wrote:
> This patch add regmap initialization to use register map
> in max8997-clk device driver
> 
> CC: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---

Patch looks good to me. Now that the driver uses regmap, I think you should
be able to get rid of drivers/mfd/max8997-irq.c and use the regmap IRQ chip
like is done in most Maxim PMIC MFD drivers.

That can be done as a follow-up of this series though.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
