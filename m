From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 13:26:44 -0600
Subject: [PATCH v3 2/7] dt-bindings: display: Add Allwinner MIPI-DSI
 bindings
In-Reply-To: <5f183ae295c0190369ec576ecfb10c1d78f41eb3.1520344489.git-series.maxime.ripard@bootlin.com>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <5f183ae295c0190369ec576ecfb10c1d78f41eb3.1520344489.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180307192644.7kowpqidew3jq2bw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 02:55:59PM +0100, Maxime Ripard wrote:
> From: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> The Allwinner SoCs usually come with a DSI encoder. Add a binding for it.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 93 +++++++-
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt

Reviewed-by: Rob Herring <robh@kernel.org>
