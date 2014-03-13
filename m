From: broonie@kernel.org (Mark Brown)
Date: Thu, 13 Mar 2014 13:46:01 +0000
Subject: [PATCH 00/18] edma/ASoC: dmaengine PCM for AM335x and AM447x
In-Reply-To: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
References: <1394702320-21743-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20140313134601.GU366@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 11:18:22AM +0200, Peter Ujfalusi wrote:

> With this series AM335x and AM447x will use the dmaengine PCM for audio. The
> daVinci devices will keep using the davinci-pcm for now since I do not have
> means to test them but the code is written in a way that they can be switched
> to use the edma-pcm easily (DA850/OMAP-L138 has been tested and audio was
> working fine).

Can you please not resend the ASoC portions of this series until the
EDMA portion is stable (and ideally committed)?  I'm not quite sure why
but every EDMA patch series seems to go through lots of iterations which
gets rather noisy - my initial reaction to seeing EDMA in a subject is
to just delete the thread.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140313/84806c4c/attachment.sig>
