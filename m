From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Apr 2015 11:56:23 +0100
Subject: [RESEND RFC PATCH 1/3] ASoC: mediatek: Add binding support for
 AFE driver
In-Reply-To: <1429611306.23823.52.camel@mtksdaap41>
References: <1428653649-38200-1-git-send-email-koro.chen@mediatek.com>
 <1428653649-38200-2-git-send-email-koro.chen@mediatek.com>
 <20150418173407.GE26185@sirena.org.uk>
 <20150420043747.GH6325@pengutronix.de>
 <20150420204849.GJ14892@sirena.org.uk>
 <20150421094926.GU6325@pengutronix.de>
 <1429611306.23823.52.camel@mtksdaap41>
Message-ID: <20150421105623.GG22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 06:15:06PM +0800, Koro Chen wrote:
> On Tue, 2015-04-21 at 11:49 +0200, Sascha Hauer wrote:

> > there are two programmable hardware gain blocks which can be inserted to
> > the digital audio path using the crossbar switch. There must be some
> > mechanism to configure them into different places.

> Maybe in DPCM, they can be "widgets", and we can define "routes" and
> corresponding controls for them. 

Yes, exactly - it's basically just like a CODEC.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150421/8bf8f506/attachment.sig>
