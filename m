From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon,  5 Nov 2018 12:37:23 -0800
Subject: [PATCH 1/1] bus: brcmstb_gisb: simplify getting .driver_data
In-Reply-To: <20181021195958.1412-2-wsa+renesas@sang-engineering.com>
References: <20181021195958.1412-1-wsa+renesas@sang-engineering.com>
 <20181021195958.1412-2-wsa+renesas@sang-engineering.com>
Message-ID: <20181105203723.7031-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Oct 2018 21:59:58 +0200, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied to drivers/next, thanks!
--
Florian
