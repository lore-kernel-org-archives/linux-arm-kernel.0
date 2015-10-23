From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 18:02:15 +0200
Subject: [PATCH v3] VFIO: platform: reset: AMD xgbe reset module
In-Reply-To: <1445615913-31825-1-git-send-email-eric.auger@linaro.org>
References: <1445615913-31825-1-git-send-email-eric.auger@linaro.org>
Message-ID: <4674490.OAKeLluVeG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 17:58:33 Eric Auger wrote:
> This patch introduces a module that registers and implements a low-level
> reset function for the AMD XGBE device.
> 
> it performs the following actions:
> - reset the PHY
> - disable auto-negotiation
> - disable & clear auto-negotiation IRQ
> - soft-reset the MAC
> 
> Those tiny pieces of code are inherited from the native xgbe driver.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
