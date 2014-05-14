From: rogerq@ti.com (Roger Quadros)
Date: Wed, 14 May 2014 15:57:56 +0300
Subject: [PATCH 01/17] phy: phy-omap-pipe3: Add support for PCIe PHY
In-Reply-To: <1399383244-14556-2-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <1399383244-14556-2-git-send-email-kishon@ti.com>
Message-ID: <53736854.7090101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 04:33 PM, Kishon Vijay Abraham I wrote:
> PCIe PHY uses an external pll instead of the internal pll used by SATA
> and USB3. So added support in pipe3 PHY to use external pll.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

--
cheers,
-roger
