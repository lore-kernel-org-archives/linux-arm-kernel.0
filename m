From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Aug 2013 11:18:49 +0100
Subject: [PATCH 1/5] ALSA: move dmaengine implementation from ASoC to
 ALSA core
In-Reply-To: <1376296961-20564-2-git-send-email-zonque@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
 <1376296961-20564-2-git-send-email-zonque@gmail.com>
Message-ID: <20130815101849.GX2401@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:42:37AM +0200, Daniel Mack wrote:
> For the PXA DMA rework, we need the generic dmaengine implementation
> that currently lives in sound/soc for standalone (non-ASoC) AC'97
> support.

Applied, thanks.  Remember to use git format-patch -M for moves and
renames.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/8821d5cd/attachment.sig>
