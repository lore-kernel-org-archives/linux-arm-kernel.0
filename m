From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 12:29:49 +0100
Subject: [PATCH v6 1/8] ASoC: wm8731: add rates constraints
In-Reply-To: <1375180329-4860-2-git-send-email-richard.genoud@gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130730112949.GP9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:32:02PM +0200, Richard Genoud wrote:
> Depending on the mclk (or crystal) selected, the wm8731 codec have some
> constraints on its data sampling rates:
> e.g. with a 12.288MHz or 18.432MHz crystal, the authorized rates are
> 8KHz, 32KHz, 48KHz and 96KHz.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/8b2d57f8/attachment.sig>
