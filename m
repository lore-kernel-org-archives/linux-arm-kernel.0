From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 17:32:58 +0100
Subject: [PATCH 17/20] ASoC: pxa: pxa-pcm-lib: switch over to
 snd-soc-dmaengine-pcm
In-Reply-To: <5202718F.2050507@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
 <1375889649-14638-18-git-send-email-zonque@gmail.com>
 <20130807160743.GI6427@sirena.org.uk> <5202718F.2050507@gmail.com>
Message-ID: <20130807163258.GL6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 06:10:55PM +0200, Daniel Mack wrote:
> On 07.08.2013 18:07, Mark Brown wrote:

> > Has this been tested with the standalone non-ASoC PXA AC'97 driver?

> Nope. I have no such device.

I guess the main test there will be making sure that it builds with ASoC
disabled.  I'm not sure anything later than PXA3xx ever actually used
AC'97.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/5584ac0c/attachment.sig>
