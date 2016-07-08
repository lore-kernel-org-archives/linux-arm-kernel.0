From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 8 Jul 2016 11:11:57 -0700
Subject: [PATCH v2 5/6] net: ethernet: bgmac: Add platform device support
In-Reply-To: <1467932938-21819-6-git-send-email-jon.mason@broadcom.com>
References: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
 <1467932938-21819-6-git-send-email-jon.mason@broadcom.com>
Message-ID: <577FECED.6060906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 04:08 PM, Jon Mason wrote:
> The bcma portion of the driver has been split off into a bcma specific
> driver.  This has been mirrored for the platform driver.  The last
> references to the bcma core struct have been changed into a generic
> function call.  These function calls are wrappers to either the original
> bcma code or new platform functions that access the same areas via MMIO.
> This necessitated adding function pointers for both platform and bcma to
> hide which backend is being used from the generic bgmac code.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
