From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Wed, 2 Nov 2016 10:12:25 -0700
Subject: [PATCH v5 3/7] net: phy: broadcom: Add BCM54810 PHY entry
In-Reply-To: <1478106488-11779-4-git-send-email-jon.mason@broadcom.com>
References: <1478106488-11779-1-git-send-email-jon.mason@broadcom.com>
 <1478106488-11779-4-git-send-email-jon.mason@broadcom.com>
Message-ID: <c8d6f062-f5f4-dc07-4cc6-33dbe2c22943@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2016 10:08 AM, Jon Mason wrote:
> The BCM54810 PHY requires some semi-unique configuration, which results
> in some additional configuration in addition to the standard config.
> Also, some users of the BCM54810 require the PHY lanes to be swapped.
> Since there is no way to detect this, add a device tree query to see if
> it is applicable.
> 
> Inspired-by: Vikas Soni <vsoni@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
