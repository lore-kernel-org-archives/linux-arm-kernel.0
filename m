From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 13 Aug 2014 10:58:16 -0700
Subject: [PATCH] watchdog: xilinx: Remove .owner field for driver
In-Reply-To: <e8e4f914035bfd055525e224da9d3e62e70edb1b.1407930684.git.michal.simek@xilinx.com>
References: <e8e4f914035bfd055525e224da9d3e62e70edb1b.1407930684.git.michal.simek@xilinx.com>
Message-ID: <20140813175816.GA16662@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 01:51:28PM +0200, Michal Simek wrote:
> There is no need to init .owner field.
> 
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
> 
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter
