From: coelho@ti.com (Luciano Coelho)
Date: Fri, 26 Apr 2013 09:32:59 +0300
Subject: [PATCH 3/3] ARM: dts: Add muxing for wl12xx on the SDIO bus for
 blaze
In-Reply-To: <20130426035216.26065.32776.stgit@muffinssi.local>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
 <20130426035216.26065.32776.stgit@muffinssi.local>
Message-ID: <1366957979.4029.17.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> This should work assuming the board-4430sdp.c works, but it seems
> that I don't have the "1283 PG 2.21 connectivity device" on
> my blaze. Anybody got a spare connectivity device for blaze?
> 
> Also, if somebody has the schematics, please provide a patch
> for the missing GPIO muxes for blaze, see the the panda for
> what's currently missing.
> 
> Cc: Luciano Coelho <coelho@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Tested-by: Luciano Coelho <coelho@ti.com>

-- 
Luca.
