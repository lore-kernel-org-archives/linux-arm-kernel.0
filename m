From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Oct 2013 11:34:09 +0100
Subject: [PATCH v2 2/8] ASoC: Samsung: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <1381950659-12703-3-git-send-email-tomasz.figa@gmail.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
 <1381950659-12703-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20131017103409.GM2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 09:10:53PM +0200, Tomasz Figa wrote:
> With support for amba-pl08x driver, on S3C64xx the generic DMA engine
> API can be used instead of the private s3c-dma interface.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Acked-by: Mark Brown <broonie@linaro.org>

in case we can get this into v3.13.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131017/af3ec6b3/attachment-0001.sig>
