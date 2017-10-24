From: robh@kernel.org (Rob Herring)
Date: Tue, 24 Oct 2017 11:36:00 -0500
Subject: [PATCH 06/10] clk: sunxi-ng: sun4i: Export video PLLs
In-Reply-To: <20171017121807.2994-7-wens@csie.org>
References: <20171017121807.2994-1-wens@csie.org>
 <20171017121807.2994-7-wens@csie.org>
Message-ID: <20171024163600.2bk2kocrwh3eiji5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 08:18:03PM +0800, Chen-Yu Tsai wrote:
> From: Jonathan Liu <net147@gmail.com>
> 
> The video PLLs are used directly by the HDMI controller. Export them so
> that we can use them in our DT node.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.h      | 4 ++--
>  include/dt-bindings/clock/sun4i-a10-ccu.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
