From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 8 Jul 2016 11:11:39 -0700
Subject: [PATCH v2 4/6] net: ethernet: bgmac: convert to feature flags
In-Reply-To: <1467932938-21819-5-git-send-email-jon.mason@broadcom.com>
References: <1467932938-21819-1-git-send-email-jon.mason@broadcom.com>
 <1467932938-21819-5-git-send-email-jon.mason@broadcom.com>
Message-ID: <577FECDB.5010608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 04:08 PM, Jon Mason wrote:
> The bgmac driver is using the bcma provides device ID and revision, as
> well as the SoC ID and package, to determine which features are
> necessary to enable, reset, etc in the driver.   In anticipation of
> removing the bcma requirement for this driver, these must be changed to
> not reference that struct.  In place of that, each "feature" has been
> given a flag, and the flags are enabled for their respective device and
> SoC.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
