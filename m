From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 13:36:25 -0600
Subject: [PATCH v3 04/16] clk: sunxi-ng: h3: h5: export CLK_PLL_VIDEO
In-Reply-To: <20180301213442.16677-5-jernej.skrabec@siol.net>
References: <20180301213442.16677-1-jernej.skrabec@siol.net>
 <20180301213442.16677-5-jernej.skrabec@siol.net>
Message-ID: <20180307193625.twmxfo3fiy4sjeuk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 10:34:30PM +0100, Jernej Skrabec wrote:
> CLK_PLL_VIDEO needs to be referenced in HDMI DT entry as a possible
> PHY clock parent.
> 
> Export it so it can be used later in DT.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-h3.h      | 4 +++-
>  include/dt-bindings/clock/sun8i-h3-ccu.h | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
