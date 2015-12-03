From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Dec 2015 11:01:58 +0000
Subject: [alsa-devel] [PATCH] ASoC: mediatek: Use current HW pointer for
 pointer callback
In-Reply-To: <s5h8u5b98dp.wl-tiwai@suse.de>
References: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
 <s5h8u5b98dp.wl-tiwai@suse.de>
Message-ID: <20151203110158.GD5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 10:41:38AM +0100, Takashi Iwai wrote:

> While reading this patch, I wondered how regmap can be used safely in
> an irq-disabled context.  Mark, do we have any API for that?

We can use user supplied locks or spin_lock_irqsave().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/9b4a77ca/attachment.sig>
