From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 1 Mar 2011 14:43:31 +0000
Subject: [PATCH v2 1/4] ASoC: Add TI tlv320aic32x4 codec support.
In-Reply-To: <AANLkTinSqVuuiif33yd1zZBTzeb4mvvLpDd4+=RPiHHM@mail.gmail.com>
References: <1298988128-11520-1-git-send-email-javier.martin@vista-silicon.com>
	<1298988128-11520-2-git-send-email-javier.martin@vista-silicon.com>
	<20110301142231.GH9662@opensource.wolfsonmicro.com>
	<AANLkTinSqVuuiif33yd1zZBTzeb4mvvLpDd4+=RPiHHM@mail.gmail.com>
Message-ID: <20110301144331.GI9662@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 01, 2011 at 03:36:13PM +0100, javier Martin wrote:

> Ok, let me organize all this stuff for better understanding. By the
> way, when you said it should be configured by platform are you
> referring to machine driver or to board specific code? Can you please

Either the machine driver or board specific code depending on what's
idiomatic for the thing you're configuring (they're both machine
specific anyway).  

> point me to a codec driver which uses a similar approach?

Quite a lot of CODEC drivers have platform data of various kinds, pretty
much all of them have an include file in include/sound - look there for
a list.
