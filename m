From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 15:28:52 +0100
Subject: AB8500 Regulators
In-Reply-To: <5017EA01.6090401@linaro.org>
References: <501690F7.2010904@linaro.org>
 <20120730152618.GI4468@opensource.wolfsonmicro.com>
 <5016B70A.1030601@linaro.org>
 <20120730174831.GP4468@opensource.wolfsonmicro.com>
 <50179B64.60209@linaro.org>
 <20120731110830.GY4468@opensource.wolfsonmicro.com>
 <5017CEE4.5010602@linaro.org>
 <20120731134716.GL4468@opensource.wolfsonmicro.com>
 <5017EA01.6090401@linaro.org>
Message-ID: <20120731142852.GX4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:21:53PM +0100, Lee Jones wrote:
> On 31/07/12 14:47, Mark Brown wrote:

> >>The only thing of interest that I could see was the regulator_init()
> >>call-back. Is this what you were alluding to in the first link?

> >No.  apply_uV.

> Ah, nice.

> So is it worth me making at least those changes, so we can start
> thinning down our platform data overhead?

Implementing support for framework features is of course useful.
