From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Nov 2015 14:34:31 +0000
Subject: [PATCH v1 1/5] ASoC: rockchip: i2s: Support to set the divider
 clock API
In-Reply-To: <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
 <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
Message-ID: <20151104143431.GH1717@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 09:33:54AM +0800, Caesar Wang wrote:
> In order to support more sample rates, add the divider clock api.
> 
> As the input source clock to the module is MCLK_I2S,
> and by the divider of the module, the clock generator generates
> SCLK and LRCK to transmitter and receiver.

Same thing as your other very similar patch: why does this feature
require set_clkdiv()?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/210e1dc7/attachment.sig>
