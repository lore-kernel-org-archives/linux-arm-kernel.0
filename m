From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Apr 2010 10:54:15 +0100
Subject: AC97 problems with pxa...
In-Reply-To: <4BBD9F28.9080804@bitsim.com>
References: <4BBBACBE.7040505@bitsim.com>
	<201004070950.37809.marek.vasut@gmail.com>
	<4BBC5254.7040200@bitsim.com>
	<20100407095449.GA13576@rakim.wolfsonmicro.main>
	<4BBD9F28.9080804@bitsim.com>
Message-ID: <20100408095415.GC6303@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 11:17:28AM +0200, Jakob Viketoft wrote:

> The dmesg output:
> Registered platform 'pxa2xx-audio'
> Error: Driver 'pxa2xx-ac97' is already registered, aborting...

Have you compiled in both the sound/arm and sound/soc AC97 support by
any chance?
