From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 09 Feb 2014 12:05:27 -0800
Subject: [PATCH 02/10] watchdog: xilinx: Move control_status_reg to
 functions
In-Reply-To: <ca50a63f8e204043247268217f7981102da1e530.1391177880.git.michal.simek@xilinx.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <ca50a63f8e204043247268217f7981102da1e530.1391177880.git.michal.simek@xilinx.com>
Message-ID: <52F7DF87.9040409@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> control_status_reg is temp variables and should be
> used locally by specific function.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
