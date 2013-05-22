From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 May 2013 11:42:10 -0500
Subject: [PATCH] ASoC: Add support for BCM2708
In-Reply-To: <519CED72.40406@koalo.de>
References: <519CD1CC.8070507@koalo.de> <519CE2B7.8080704@wwwdotorg.org>
 <519CED72.40406@koalo.de>
Message-ID: <20130522164210.GS1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 06:08:18PM +0200, Florian Meier wrote:
> On 22.05.2013 17:22, Stephen Warren wrote:

> > I assume you're planning on sending the DMA driver upstream too? I guess
> > this driver isn't useful without it.

> I would like to, but it only supports cyclic DMA. Should I send it
> upstream anyway? In case you are interested:

It seems better to send something partially featured upstream so that
people can work on enhancing it rather than having nothing all upstream.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130522/d5bbd7bc/attachment.sig>
