From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 12:07:31 -0500
Subject: [PATCH 2/3] clk: sunxi: Add sun6i/8i PLL video support
In-Reply-To: <e63499f789971b8c45a0ae5e90bd127371cbcf19.1459358017.git.moinejf@free.fr>
References: <cover.1459358017.git.moinejf@free.fr>
 <e63499f789971b8c45a0ae5e90bd127371cbcf19.1459358017.git.moinejf@free.fr>
Message-ID: <20160401170731.GA4007@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 06:50:43PM +0200, Jean-Francois Moine wrote:
> Add the PLL type which is used by the sun6i/8i families for video display.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/clk/sunxi/clk-sunxi.c                     | 65 +++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
