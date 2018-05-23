From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 13:20:01 -0500
Subject: [PATCH 03/15] clk: sunxi-ng: r40: Export video PLLs
In-Reply-To: <20180519183127.2718-4-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-4-jernej.skrabec@siol.net>
Message-ID: <20180523182001.GA4527@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 08:31:15PM +0200, Jernej Skrabec wrote:
> Video PLLs need to be referenced in R40 DT as possible HDMI PHY parent.
> 
> Export them.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 8 ++++++--
>  include/dt-bindings/clock/sun8i-r40-ccu.h | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
