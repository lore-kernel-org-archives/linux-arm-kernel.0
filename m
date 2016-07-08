From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 8 Jul 2016 11:11:05 -0700
Subject: [PATCH v2 2/6] net: ethernet: bgmac: add dma_dev pointer
In-Reply-To: <1467932938-21819-3-git-send-email-jon.mason@broadcom.com>
References: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
 <1467932938-21819-3-git-send-email-jon.mason@broadcom.com>
Message-ID: <577FECB9.5090508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 04:08 PM, Jon Mason wrote:
> The dma buffer allocation, etc references a dma_dev device pointer from
> the bcma core.  In anticipation of removing the bcma requirement for
> this driver, these must be changed to not reference that struct.  Add a
> dma_dev device pointer to the bgmac stuct and reference that instead.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
