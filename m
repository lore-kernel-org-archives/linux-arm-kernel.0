From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Nov 2012 18:24:35 +0900
Subject: [PATCH 2/2] ASoC: atmel-pcm: add dma support
In-Reply-To: <50AB4BBB.7050308@atmel.com>
References: <1353400698-19384-1-git-send-email-voice.shen@atmel.com>
 <1353400698-19384-2-git-send-email-voice.shen@atmel.com>
 <20121120085728.GX10560@opensource.wolfsonmicro.com>
 <50AB4BBB.7050308@atmel.com>
Message-ID: <20121120092433.GB10560@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 05:22:03PM +0800, Bo Shen wrote:
> On 11/20/2012 16:57, Mark Brown wrote:

> >If you're using dmaengine you really need a *very* good reason not to
> >use the core dmaengine support...

> You mean I should using the soc-dmaengine-pcm, am I right?

Yes, that's right.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/471926f8/attachment.sig>
