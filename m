From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 09 Feb 2014 12:09:06 -0800
Subject: [PATCH 04/10] watchdog: xilinx: Move no_timeout to probe function
In-Reply-To: <8273bfbdf42dcd94f4e05a543de19b200f192e66.1391177880.git.michal.simek@xilinx.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <8273bfbdf42dcd94f4e05a543de19b200f192e66.1391177880.git.michal.simek@xilinx.com>
Message-ID: <52F7E062.9060102@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> no_timeout should be local variable because it is used
> only in probe function.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
