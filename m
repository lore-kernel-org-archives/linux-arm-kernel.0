From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 25 Aug 2011 12:37:15 +0100
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <201108232351.55432.rjw@sisk.pl>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<201108232351.55432.rjw@sisk.pl>
Message-ID: <20110825113715.GA2061@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 11:51:55PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, August 23, 2011, Mark Brown wrote:

> > and the boot runs very slowly.  Reverting the series merged in 56f0be
> > appears to resolve the issue,

> In fact, the patch from:

> https://patchwork.kernel.org/patch/1083602/

> is sufficient to make the calltrace go away.

Yes, that works for me too thanks!

Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
