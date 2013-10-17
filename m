From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Oct 2013 11:22:01 +0100
Subject: [PATCH v2 0/8] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
References: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20131017102201.GK2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 09:10:51PM +0200, Tomasz Figa wrote:
> Since the patches extending support of amba-pl08x DMA engine driver to
> PL080S DMA engine (PL080 modified by Samsung) found in Samsung S3C64xx
> SoCs got merged into Linux 3.12, it is a good time to migrate the
> platform to use this driver and drop the legacy DMA code.

Tested-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131017/6e770963/attachment.sig>
