From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Apr 2010 10:54:49 +0100
Subject: AC97 problems with pxa...
In-Reply-To: <4BBC5254.7040200@bitsim.com>
References: <4BBBACBE.7040505@bitsim.com>
	<201004070950.37809.marek.vasut@gmail.com>
	<4BBC5254.7040200@bitsim.com>
Message-ID: <20100407095449.GA13576@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 07, 2010 at 11:37:24AM +0200, Jakob Viketoft wrote:

Please don't top post...

> Do you mean mixing the AC97 non-asoc and asoc drivers or the drivers
> for the WM9712? I can't see the possibility of mixing anything for
> the WM9712, but I'm unsure of the distinction between the different
> AC97 pieces.

...without context it's hard to work out what you are talking about.

> Should this make a difference? My module init function gets called,
> it's just the snd_soc_dai_link[0].init function that doesn't.

Build soc-core.c with #define DEBUG at the top then look at your logs
