From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 Oct 2015 18:05:44 +0100
Subject: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring issue
In-Reply-To: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
Message-ID: <20151002170544.GX12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 10:43:17PM +0800, yitian wrote:

> --- a/sound/soc/dwc/designware_i2s.c
> +++ b/sound/soc/dwc/designware_i2s.c
> @@ -141,13 +141,22 @@ static inline void i2s_clear_irqs(struct dw_i2s_dev
> *dev, u32 stream)

This doesn't apply because it's been corrupted by line wrapping - git am
can't understand it.  Since it's just that one line I fixed it up by
hand but please look at your mail setup to make sure this works (this
might've been what happened with your other patch yesterday).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151002/f4f1ac4f/attachment.sig>
