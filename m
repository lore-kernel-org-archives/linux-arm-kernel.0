From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 16:58:05 +0100
Subject: [PATCH 15/20] ASoC: pxa: pxa-ssp: set dma filter data from
 startup hook
In-Reply-To: <1375889649-14638-16-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-16-git-send-email-zonque@gmail.com>
Message-ID: <20130807155805.GG6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:34:04PM +0200, Daniel Mack wrote:
> With the new dmaengine implementation, the filter_data parameter has
> to be set earlier, from pxa_ssp_startup().

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/8f30627e/attachment.sig>
