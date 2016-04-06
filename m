From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Apr 2016 10:17:50 -0700
Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
 driver
In-Reply-To: <1459951105.28748.12.camel@mtksdaap41>
References: <1458877325-33980-1-git-send-email-pc.liao@mediatek.com>
 <20160328191115.GE2350@sirena.org.uk>
 <1459258103.3747.7.camel@mtksdaap41>
 <20160329160703.GN2350@sirena.org.uk>
 <1459479052.24414.3.camel@mtksdaap41>
 <20160402170404.GG2350@sirena.org.uk>
 <1459951105.28748.12.camel@mtksdaap41>
Message-ID: <20160406171750.GR1924@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 09:58:25PM +0800, PC Liao wrote:
> On Sun, 2016-04-03 at 01:04 +0800, Mark Brown wrote:

> > Any driver that can identify an individual DAI within a device by using
> > sound-dai references, even simple-card does this.

> Thanks for suggestion.
> This machine driver is based on DPCM.
> Should I add BE DAI and use DAPM, then using ucm-config(mixer control)
> to control the path?
> Or, do I think the wrong direction?
> Thanks!

It sounds like the configuration is fixed in these systems and can't
be usefully varied at runtime?  If that's the case then there's no need
for a userspace control.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160406/ea49fd01/attachment.sig>
