From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 16:13:09 -0500
Subject: [PATCH v2 4/6] drm/panel: simple: Add support for Banana Pi 7"
 S070WV20-CT16 panel
In-Reply-To: <20180907041948.19913-5-wens@csie.org>
References: <20180907041948.19913-1-wens@csie.org>
 <20180907041948.19913-5-wens@csie.org>
Message-ID: <20180925211309.GA12535@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Sep 2018 12:19:46 +0800, Chen-Yu Tsai wrote:
> This panel is marketed as Banana Pi 7" LCD display. On the back is
> a sticker denoting the model name S070WV20-CT16.
> 
> This is a 7" 800x480 panel connected through a 24-bit RGB interface.
> However the panel only does 262k colors.
> 
> Depending on the variant, the PCB attached to the panel module either
> supports DSI, or DSI + 24-bit RGB. DSI is converted to 24-bit RGB via
> an onboard ICN6211 MIPI DSI - RGB bridge chip, then fed to the panel
> itself.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../display/panel/bananapi,s070wv20-ct16.txt  | 12 +++++++++
>  drivers/gpu/drm/panel/panel-simple.c          | 25 +++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
