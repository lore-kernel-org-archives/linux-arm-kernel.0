From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Nov 2013 11:07:52 -0700
Subject: [PATCH][RESEND 7/8] ASoC: davinci: use gen_pool_dma_alloc() in
 davinci-pcm.c
In-Reply-To: <8bd26b17552315f0a3ea63c166a97a938c88dcf0.1383306365.git.b42378@freescale.com>
References: <cover.1383306365.git.b42378@freescale.com>
 <8bd26b17552315f0a3ea63c166a97a938c88dcf0.1383306365.git.b42378@freescale.com>
Message-ID: <20131101180752.GA2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 01, 2013 at 07:48:20PM +0800, Nicolin Chen wrote:
> Since gen_pool_dma_alloc() is introduced, we implement it to simplify code.

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131101/1dc23a17/attachment.sig>
