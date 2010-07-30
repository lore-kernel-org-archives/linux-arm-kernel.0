From: gadiyar@ti.com (Anand Gadiyar)
Date: Fri, 30 Jul 2010 18:06:54 +0530
Subject: [PATCH] [ARM] tegra: Add i2c support
In-Reply-To: <1280450180-25016-1-git-send-email-ccross@google.com>
References: <1280450180-25016-1-git-send-email-ccross@google.com>
Message-ID: <4C52C766.7040709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2010 06:06 AM, Colin Cross wrote:
> +/* i2c_writel and i2c_readl will offset the register if necessary to talk
> + * to the I2C block inside the DVC block
> + */

Minor coding-style comment. Documentation/CodingStyle says the preferred
format for multi-line comments is to do:

/*
  * i2c_writel and i2c_readl ...
  * to the I2C block ...
  */

Not sure if you need to fix this in this patch, but it's probably a good 
idea to follow for future patches.

- Anand
