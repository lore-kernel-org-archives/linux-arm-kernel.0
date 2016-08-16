From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 18:41:41 +0200
Subject: [RFC 12/17] ASoC: samsung: Switch to new clock controller API
In-Reply-To: <20160816141345.GT9347@sirena.org.uk>
References: <1471354514-24224-1-git-send-email-k.kozlowski@samsung.com>
 <1471354514-24224-13-git-send-email-k.kozlowski@samsung.com>
 <20160816141345.GT9347@sirena.org.uk>
Message-ID: <20160816164141.GB9249@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 03:13:45PM +0100, Mark Brown wrote:
> On Tue, Aug 16, 2016 at 03:35:09PM +0200, Krzysztof Kozlowski wrote:
> > Allocate a clock controller and use new clk_register_with_ctrl() API.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> >  	i2s_unregister_clocks(i2s);
> > +	clk_ctrl_unregister(i2s->clk_ctrl);
> 
> devm?

Right, that would make sense. Thanks for pointing this out.

Best regards,
Krzysztof
