From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 09 Feb 2014 12:13:01 -0800
Subject: [PATCH 05/10] watchdog: xilinx: Allocate private structure per
 device
In-Reply-To: <255ff18dc52347e1bc8b0a0060eaa1037e02bdaa.1391177880.git.michal.simek@xilinx.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <255ff18dc52347e1bc8b0a0060eaa1037e02bdaa.1391177880.git.michal.simek@xilinx.com>
Message-ID: <52F7E14D.8060607@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> Only one watchdog could be used by this driver.
> Create driver private data structure and move there
> all variables for one instance.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
