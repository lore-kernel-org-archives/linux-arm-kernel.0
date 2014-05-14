From: rogerq@ti.com (Roger Quadros)
Date: Wed, 14 May 2014 16:20:33 +0300
Subject: [PATCH 04/17] phy: pipe3: insert delay to enumerate in GEN2 mode
In-Reply-To: <1399383244-14556-5-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <1399383244-14556-5-git-send-email-kishon@ti.com>
Message-ID: <53736DA1.4040405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2014 04:33 PM, Kishon Vijay Abraham I wrote:
> 8-bit delay value (0xF1) is required for GEN2 devices to be enumerated
> consistently. Added an API to be called from PHY drivers to set this delay
> value and called it from PIPE3 driver to set the delay value.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

--
cheers,
-roger
