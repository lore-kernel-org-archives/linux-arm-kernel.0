From: rogerq@ti.com (Roger Quadros)
Date: Wed, 14 May 2014 16:02:21 +0300
Subject: [PATCH 02/17] phy: omap-control: add external clock support for
 PCIe PHY
In-Reply-To: <1399383244-14556-3-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <1399383244-14556-3-git-send-email-kishon@ti.com>
Message-ID: <5373695D.2090702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 04:33 PM, Kishon Vijay Abraham I wrote:
> Export an API to be called by PIPE3 PHY to enable external clock for
> PCIE PHY. Added a new compatible for PCIE in omap-control in order to
> enable it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

--
cheers,
-roger
