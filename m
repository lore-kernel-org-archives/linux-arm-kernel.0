From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 17:36:11 +0100
Subject: [alsa-devel] [PATCH 09/18] ASoC: Samsung: Do not queue cyclic
 buffers multiple times
In-Reply-To: <1376243970-6489-10-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-10-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130829163611.GL10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 07:59:21PM +0200, Tomasz Figa wrote:
> The legacy S3C-DMA API required every period of a cyclic buffer to be
> queued separately. After conversion of Samsung ASoC to Samsung DMA
> wrappers somebody made an assumption that the same is needed for DMA
> engine API, which is not true.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/fc388564/attachment.sig>
