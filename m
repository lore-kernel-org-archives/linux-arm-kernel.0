From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Apr 2018 16:23:42 -0500
Subject: [PATCH 6/7] clk: sunxi-ng: sun5i: Export the MBUS clock
In-Reply-To: <6d6004e057609109f6b3a0c014c30f7914eb4401.1522761929.git-series.maxime.ripard@bootlin.com>
References: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
 <6d6004e057609109f6b3a0c014c30f7914eb4401.1522761929.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180409212342.xoxmbm6onj2xjmu3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 03:29:19PM +0200, Maxime Ripard wrote:
> The MBUS clock is used by the MBUS controller, so let's export it so that
> we can use it in our DT node.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun5i.h      | 4 ----
>  include/dt-bindings/clock/sun5i-ccu.h | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
