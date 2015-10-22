From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Oct 2015 01:50:17 +0900
Subject: [PATCH v2 2/3] Documentation: DT bindings: rockchip-i2s: add
 capture property
In-Reply-To: <1444308009-29088-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
 <1444308009-29088-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20151022165017.GA8232@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 08:40:08PM +0800, Sugar Zhang wrote:

> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
> @@ -21,6 +21,7 @@ Required properties:
>  - clock-names: should contain followings:
>     - "i2s_hclk": clock for I2S BUS
>     - "i2s_clk" : clock for I2S controller
> +- rockchip,capture-channels: max capture channels, if not set, 2 channels default.

If this can not be set then it's an optional property, not a required
property, and should be in the optional properties section.  Please send
a followup patch fixing that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151023/9b9773ea/attachment.sig>
