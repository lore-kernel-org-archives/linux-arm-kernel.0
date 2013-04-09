From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 9 Apr 2013 20:59:27 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: HWMOD: make 'ocp2scp_usb_phy_phy_48m" as
 the main clock
In-Reply-To: <1365496101-7829-1-git-send-email-kishon@ti.com>
References: <1365496101-7829-1-git-send-email-kishon@ti.com>
Message-ID: <alpine.DEB.2.00.1304092058450.26840@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, 9 Apr 2013, Kishon Vijay Abraham I wrote:

> commit 92702d (ARM: OMAP4: PM: fix PM regression introduced by recent
> clock cleanup) makes the 'ocp2scp_usb_phy_phy_48m' as optional
> functional clock causing regression in MUSB. But this 48MHz clock is a
> mandatory clock for usb phy attached to ocp2scp and hence made as the main
> clock for ocp2scp.
> 
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

This patch is missing the "big comment" that I requested in the hwmod 
data:

http://marc.info/?l=linux-omap&m=136544098331552&w=2

Once that's added, it should be good to go.


- Paul
