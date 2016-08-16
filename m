From: broonie@kernel.org (Mark Brown)
Date: Tue, 16 Aug 2016 15:13:45 +0100
Subject: [RFC 12/17] ASoC: samsung: Switch to new clock controller API
In-Reply-To: <1471354514-24224-13-git-send-email-k.kozlowski@samsung.com>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
 <1471354514-24224-13-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160816141345.GT9347@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 03:35:09PM +0200, Krzysztof Kozlowski wrote:
> Allocate a clock controller and use new clk_register_with_ctrl() API.

Acked-by: Mark Brown <broonie@kernel.org>

>  	i2s_unregister_clocks(i2s);
> +	clk_ctrl_unregister(i2s->clk_ctrl);

devm?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160816/31281df2/attachment.sig>
