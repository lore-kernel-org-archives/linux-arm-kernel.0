From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 02 Nov 2018 13:25:32 +0100
Subject: [PATCH 2/5] thermal: rockchip_thermal: simplify getting
 .driver_data
In-Reply-To: <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
References: <20181021200053.2194-1-wsa+renesas@sang-engineering.com>
 <20181021200053.2194-3-wsa+renesas@sang-engineering.com>
Message-ID: <2099094.tBqgur4jcY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 21. Oktober 2018, 22:00:49 CET schrieb Wolfram Sang:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
