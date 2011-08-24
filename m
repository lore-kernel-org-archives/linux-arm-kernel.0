From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Aug 2011 20:19:07 +0100
Subject: [alsa-devel] [PATCH v2 1/1] ASoC: soc-core: check rate for
	symmetry only when pcm is active
In-Reply-To: <4E5548FF.1030709@metafoo.de>
References: <1314183728-23627-1-git-send-email-b29396@freescale.com>
	<4E5520CE.60204@ti.com> <4E552F5F.9070801@metafoo.de>
	<20110824172703.GF16653@opensource.wolfsonmicro.com>
	<4E5548FF.1030709@metafoo.de>
Message-ID: <20110824191906.GA21162@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 08:54:55PM +0200, Lars-Peter Clausen wrote:

> It should be sufficient to just store the rate for the cpu and codec DAI.
> Though the rate constraint should be applied if either the DAI or the link
> wants symmetric rates.

Yes, for the actual rate storage.
