From: robh@kernel.org (Rob Herring)
Date: Fri, 18 May 2018 09:23:14 -0500
Subject: [PATCH v2 16/26] dt-bindings: clock: sun50i-a64-ccu: Add
 PLL_VIDEO[0-1] macros
In-Reply-To: <20180518094536.17201-17-jagan@amarulasolutions.com>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518094536.17201-17-jagan@amarulasolutions.com>
Message-ID: <20180518142314.GA826@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 03:15:26PM +0530, Jagan Teki wrote:
> Allwinner A64 has two clock parents PLL_VIDEO0 and PLL_VIDEO1.
> 
> Include these macros on dt-bindings so-that the same can be
> used while defining CCU clock phadles.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
> 
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
