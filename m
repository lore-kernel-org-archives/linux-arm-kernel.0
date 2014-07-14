From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 19:51:58 +0100
Subject: [PATCH 3/4] ASoC: samsung: s3c24xx dmaengine follow-up
In-Reply-To: <1405086308-1461192-6-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-6-git-send-email-arnd@arndb.de>
Message-ID: <20140714185158.GC6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 03:45:07PM +0200, Arnd Bergmann wrote:
> Commit ae602456e83c92 ("ASoC: samsung: drop support for legacy
> S3C24XX DMA API") removed the old code for the samsung specific
> DMA interfaces, now that everybody can use dmaengine.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/7fffcac1/attachment.sig>
