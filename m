From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 Apr 2013 14:09:36 +0530
Subject: [PATCH v2] ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m"
 as the main clock
In-Reply-To: <alpine.DEB.2.00.1304101935450.25123@utopia.booyaka.com>
References: <1365496101-7829-1-git-send-email-kishon@ti.com>
 <alpine.DEB.2.00.1304092058450.26840@utopia.booyaka.com>
 <alpine.DEB.2.00.1304101935450.25123@utopia.booyaka.com>
Message-ID: <5167C848.4010203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 11 April 2013 01:11 AM, Paul Walmsley wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
>
> Commit 92702df3570e ("ARM: OMAP4: PM: fix PM regression introduced by recent
> clock cleanup") makes the 'ocp2scp_usb_phy_phy_48m' as optional
> functional clock causing regression in MUSB. But this 48MHz clock is a
> mandatory clock for usb phy attached to ocp2scp and hence made as the main
> clock for ocp2scp.
>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [paul at pwsan.com: add comment to the hwmod data to try to prevent any
>   future mistakes here]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>
> Nothing further received from Kishon per the request:
>
> http://marc.info/?l=linux-omap&m=136554118302342&w=2

Sorry. Missed reading this mail.

Thanks
Kishon
