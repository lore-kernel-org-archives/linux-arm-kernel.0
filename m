From: florian.fainelli@broadcom.com (Florian Fainelli)
Date: Thu, 19 Jan 2017 11:26:49 -0800
Subject: [PATCH v2 2/4] net: phy: Initialize mdio clock at probe function
In-Reply-To: <1484669670-4201-3-git-send-email-yendapally.reddy@broadcom.com>
References: <1484669670-4201-1-git-send-email-yendapally.reddy@broadcom.com>
 <1484669670-4201-3-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <8bca5f28-b6be-cf45-3982-59a8ce0db982@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 08:14 AM, Yendapally Reddy Dhananjaya Reddy wrote:
> Initialize mdio clock divisor in probe function. The ext bus
> bit available in the same register will be used by mdio mux
> to enable external mdio.
> 
> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
