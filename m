From: robh@kernel.org (Rob Herring)
Date: Mon, 31 Oct 2016 01:06:06 -0500
Subject: [PATCH v2 3/4] spi: sun6i: Add binding for Allwinner H3 SPI
 controller
In-Reply-To: <20161028065412.23008-4-woogyom.kim@gmail.com>
References: <20161028065412.23008-1-woogyom.kim@gmail.com>
 <20161028065412.23008-4-woogyom.kim@gmail.com>
Message-ID: <20161031060606.fk6vhfzyxie6ebg5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 28, 2016 at 03:54:11PM +0900, Milo Kim wrote:
> H3 SPI has same architecture as A31 except FIFO capacity.
> To configure the buffer size separately, compatible property should be
> different. Optional DMA specifiers and example are added.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  .../devicetree/bindings/spi/spi-sun6i.txt          | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
