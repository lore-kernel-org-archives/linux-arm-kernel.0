From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 May 2013 09:22:31 -0600
Subject: [PATCH] ASoC: Add support for BCM2708
In-Reply-To: <519CD1CC.8070507@koalo.de>
References: <519CD1CC.8070507@koalo.de>
Message-ID: <519CE2B7.8080704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 08:10 AM, Florian Meier wrote:
> This driver adds support for digital audio (I2S)
> for the BCM2708 SoC that is used by the
> Raspberry Pi. External audio codecs can be
> connected to the Raspberry Pi via P5 header.
> 
> It relies on cyclic DMA engine support for BCM2708
> that is not included in this patch.

This SoC is actually the BCM2835, so the files should be named for that.

Upstream only uses device tree for BCM2835. Does this driver support DT?
Where is the DT binding definition file?

I assume you're planning on sending the DMA driver upstream too? I guess
this driver isn't useful without it.

I'll take a look at the actual patch content later.
