From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 22 Oct 2018 09:12:05 +0800
Subject: [PATCH 5/5] thermal: zx2967_thermal: simplify getting .driver_data
In-Reply-To: <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-6-wsa+renesas@sang-engineering.com>
Message-ID: <20181022011203.GA13039@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 10:00:52PM +0200, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
