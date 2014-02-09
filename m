From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 9 Feb 2014 12:08:23 -0800
Subject: [03/10] watchdog: xilinx: Simplify probe and remove functions
In-Reply-To: <578455fd630e70b5de8bae6091568f05e7769057.1391177880.git.michal.simek@xilinx.com>
References: <578455fd630e70b5de8bae6091568f05e7769057.1391177880.git.michal.simek@xilinx.com>
Message-ID: <20140209200823.GA1697@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 10:18:12PM -0000, Michal Simek wrote:
> Use devm_ helper function to simplify probe and error path.
> Move ioremap to the beginning of probe function.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
