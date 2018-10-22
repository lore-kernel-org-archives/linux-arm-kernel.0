From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 22 Oct 2018 10:02:08 -0700
Subject: [PATCH 9/9] net: phy: mdio-mux-bcm-iproc: simplify getting
 .driver_data
In-Reply-To: <20181021200021.1693-10-wsa+renesas@sang-engineering.com>
References: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
 <20181021200021.1693-10-wsa+renesas@sang-engineering.com>
Message-ID: <886a1e4b-214a-8fa0-f11e-11804f4a611f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/18 1:00 PM, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
