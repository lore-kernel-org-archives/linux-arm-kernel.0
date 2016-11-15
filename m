From: robh@kernel.org (Rob Herring)
Date: Tue, 15 Nov 2016 16:22:19 -0600
Subject: [PATCH 01/10] ASoC: sunxi: Add bindings for A23/A33/H3 codec's
 analog path controls
In-Reply-To: <20161112064648.26779-2-wens@csie.org>
References: <20161112064648.26779-1-wens@csie.org>
 <20161112064648.26779-2-wens@csie.org>
Message-ID: <20161115222219.aw6clwnadx6cy6ox@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 02:46:39PM +0800, Chen-Yu Tsai wrote:
> The internal codec on A23/A33/H3 is split into 2 parts. The
> analog path controls are routed through an embedded custom register
> bus accessed through the PRCM block.
> 
> The SoCs share a common set of inputs, outputs, and audio paths.
> The following table lists the differences.
> 
>     ----------------------------------------
>     | Feature \ SoC |  A23  |  A33  |  H3  |
>     ----------------------------------------
>     | Headphone     |   v   |   v   |      |
>     ----------------------------------------
>     | Line Out      |       |       |  v   |
>     ----------------------------------------
>     | Phone In/Out  |   v   |   v   |      |
>     ----------------------------------------
> 
> Add a binding for this hardware.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/sound/sun8i-codec-analog.txt     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt

Acked-by: Rob Herring <robh@kernel.org> 
