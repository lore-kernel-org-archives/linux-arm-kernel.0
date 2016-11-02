From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 2 Nov 2016 10:17:26 -0700
Subject: [PATCH v5 6/7] net: ethernet: bgmac: add NS2 support
In-Reply-To: <1478106488-11779-7-git-send-email-jon.mason@broadcom.com>
References: <1478106488-11779-1-git-send-email-jon.mason@broadcom.com>
 <1478106488-11779-7-git-send-email-jon.mason@broadcom.com>
Message-ID: <82979ee0-1473-90fd-a9d1-23a86ce09aa8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2016 10:08 AM, Jon Mason wrote:
> Add support for the variant of amac hardware present in the Broadcom
> Northstar2 based SoCs.  Northstar2 requires an additional register to be
> configured with the port speed/duplexity (NICPM).  This can be added to
> the link callback to hide it from the instances that do not use this.
> Also, clearing of the pending interrupts on init is required due to
> observed issues on some platforms.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
