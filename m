From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 8 Jul 2016 11:10:52 -0700
Subject: [PATCH v2 1/6] net: ethernet: bgmac: change bgmac_* prints to
 dev_* prints
In-Reply-To: <1467932938-21819-2-git-send-email-jon.mason@broadcom.com>
References: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
 <1467932938-21819-2-git-send-email-jon.mason@broadcom.com>
Message-ID: <577FECAC.9070806@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 04:08 PM, Jon Mason wrote:
> The bgmac_* print wrappers call dev_* prints with the dev pointer from
> the bcma core.  In anticipation of removing the bcma requirement for
> this driver, these must be changed to not reference that struct.  So,
> simply change all of the bgmac_* prints to their dev_* counterparts.  In
> some cases netdev_* prints are more appropriate, so change those as
> well.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
