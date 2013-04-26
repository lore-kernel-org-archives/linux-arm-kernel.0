From: coelho@ti.com (Luciano Coelho)
Date: Fri, 26 Apr 2013 09:32:40 +0300
Subject: [PATCH 1/3] ARM: OMAP2+: Legacy support for wl12xx when booted
 with devicetree
In-Reply-To: <20130426035210.26065.39995.stgit@muffinssi.local>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
 <20130426035210.26065.39995.stgit@muffinssi.local>
Message-ID: <1366957960.4029.16.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> Without WLAN we cannot switch omap4 to use device tree
> only booting. This patch can be reverted when the
> binding for wl12xx is added.
> 
> Cc: Luciano Coelho <coelho@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Tested-by: Luciano Coelho <coelho@ti.com>

-- 
Luca.
