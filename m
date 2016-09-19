From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Sep 2016 16:37:27 -0500
Subject: [PATCH v15 5/5] ASoC: rockchip: Add DP dai-links to the
 rk3399-gru machine driver
In-Reply-To: <1473473748-22331-6-git-send-email-zyw@rock-chips.com>
References: <1473473748-22331-1-git-send-email-zyw@rock-chips.com>
 <1473473748-22331-6-git-send-email-zyw@rock-chips.com>
Message-ID: <20160919213727.GA22901@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 07:15:48PM -0700, Chris Zhong wrote:
> This patch adds DP audio output support to the rk3399-gru machine
> driver.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
> Changes in v15: None
> Changes in v14: None
> Changes in v13: None
> Changes in v12: None
> Changes in v11: None
> Changes in v10: None
> Changes in v9: None
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - change spdif to i2s2
> 
> Changes in v2:
> - correct the commit message
> 
> Changes in v1: None
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt   | 11 +--
>  sound/soc/rockchip/rk3399_gru_sound.c              | 93 ++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> index f19b6c8..83af540 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> @@ -1,15 +1,16 @@
> -ROCKCHIP with MAX98357A/RT5514/DA7219 codecs on GRU boards
> +ROCKCHIP with MAX98357A/RT5514/DA7219 codecs and DP via spdif on GRU boards
>  
>  Required properties:
>  - compatible: "rockchip,rk3399-gru-sound"
> -- rockchip,cpu: The phandle of the Rockchip I2S controller that's
> +- rockchip,cpu: The phandle of the Rockchip I2S controller controller that's

Huh?
