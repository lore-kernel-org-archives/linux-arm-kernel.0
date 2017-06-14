From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Jun 2017 10:01:03 -0700
Subject: [PATCH v4 04/11] net: mvmdio: remove duplicate locking
In-Reply-To: <20170614154911.14510-5-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-5-antoine.tenart@free-electrons.com>
Message-ID: <b7b5f716-9553-40fc-dc19-b016ed9cf2d9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 08:49 AM, Antoine Tenart wrote:
> From: Russell King <rmk+kernel@armlinux.org.uk>
> 
> The MDIO layer already provides per-bus locking, so there's no need for
> MDIO bus drivers to do their own internal locking.  Remove this.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
