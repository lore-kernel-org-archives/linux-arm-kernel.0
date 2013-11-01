From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Nov 2013 11:08:21 -0700
Subject: [PATCH][RESEND 8/8] ASoC: pxa: use gen_pool_dma_alloc() to
 allocate dma buffer
In-Reply-To: <290c4ed99f88c1d07544bf5f8f0c9a1d09395bed.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
 <290c4ed99f88c1d07544bf5f8f0c9a1d09395bed.1383306365.git.b42378@freescale.com>
Message-ID: <20131101180821.GB2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 07:48:21PM +0800, Nicolin Chen wrote:
> Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/fa3b0470/attachment-0001.sig>
