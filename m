From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 09 Feb 2014 12:18:12 -0800
Subject: [PATCH 07/10] watchdog: xilinx: Fix OF binding
In-Reply-To: <26d172891694e4041e73b7dae85a1848adf38034.1391177880.git.michal.simek@xilinx.com>
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com>
 <26d172891694e4041e73b7dae85a1848adf38034.1391177880.git.michal.simek@xilinx.com>
Message-ID: <52F7E284.4080603@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2014 06:18 AM, Michal Simek wrote:
> Use of_property_read_u32 functions to clean OF probing.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
