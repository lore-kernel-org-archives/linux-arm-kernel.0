From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 2 Nov 2016 19:37:14 +0100
Subject: [PATCH v5 3/7] net: phy: broadcom: Add BCM54810 PHY entry
In-Reply-To: <1478106488-11779-4-git-send-email-jon.mason@broadcom.com>
References: <1478106488-11779-1-git-send-email-jon.mason@broadcom.com>
 <1478106488-11779-4-git-send-email-jon.mason@broadcom.com>
Message-ID: <20161102183714.GH384@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 01:08:04PM -0400, Jon Mason wrote:
> The BCM54810 PHY requires some semi-unique configuration, which results
> in some additional configuration in addition to the standard config.
> Also, some users of the BCM54810 require the PHY lanes to be swapped.
> Since there is no way to detect this, add a device tree query to see if
> it is applicable.
> 
> Inspired-by: Vikas Soni <vsoni@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
