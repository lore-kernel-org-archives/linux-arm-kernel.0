From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 18 Aug 2010 16:24:34 +0100
Subject: [alsa-devel] [PATCH 1/3] ASoC: add 88pm860x codec driver
In-Reply-To: <AANLkTikc+=-3Zt+iaD+UatWR-fgv4zL=xkhQH=_0Z4m8@mail.gmail.com>
References: <AANLkTimBPhvukwqDGY8iORhY+wg8OnHi9+eOedJB2E8k@mail.gmail.com>
	<20100818141914.GC15536@sirena.org.uk>
	<AANLkTi=2FboP+xhSHjgyoM6LfmKw1khV62gTVrkxxUHF@mail.gmail.com>
	<20100818144027.GB4588@rakim.wolfsonmicro.main>
	<AANLkTikc+=-3Zt+iaD+UatWR-fgv4zL=xkhQH=_0Z4m8@mail.gmail.com>
Message-ID: <20100818152433.GA32499@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 11:23:10PM +0800, Haojian Zhuang wrote:

> In my system, there's only one physical jacks. It's four phased plug
> (mic,left,right,gnd). So I needn't split them into two different
> jacks.

Right, but the CODEC driver (which will be used by all systems with this
CODEC) should allow the user that option.
