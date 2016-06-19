From: robh@kernel.org (Rob Herring)
Date: Sun, 19 Jun 2016 09:37:54 -0500
Subject: [PATCH v2 1/4] ASoC: sunxi: Add A10 I2S controller binding
 documentation
In-Reply-To: <20160615211123.31068-2-maxime.ripard@free-electrons.com>
References: <20160615211123.31068-1-maxime.ripard@free-electrons.com>
 <20160615211123.31068-2-maxime.ripard@free-electrons.com>
Message-ID: <20160619143738.GA15829@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 11:11:20PM +0200, Maxime Ripard wrote:
> Introduce the device tree binding for the I2S controller found in the
> Allwinner A10 and later SoCs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/sound/sun4i-i2s.txt        | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt

Acked-by: Rob Herring <robh@kernel.org>
