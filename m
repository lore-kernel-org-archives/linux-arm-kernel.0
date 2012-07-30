From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 18:48:31 +0100
Subject: AB8500 Regulators
In-Reply-To: <5016B70A.1030601@linaro.org>
References: <501690F7.2010904@linaro.org>
 <20120730152618.GI4468@opensource.wolfsonmicro.com>
 <5016B70A.1030601@linaro.org>
Message-ID: <20120730174831.GP4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 05:32:10PM +0100, Lee Jones wrote:
> On 30/07/12 16:26, Mark Brown wrote:
> >On Mon, Jul 30, 2012 at 02:49:43PM +0100, Lee Jones wrote:

> >>could be dealt with using the API. There is currently no API to set
> >>up ST-Ericsson's configuration. So what's the best thing to do? How

> >Well, a good start would be to work out what those register writes
> >actually do and then we can have a discussion on how to do whatever
> >that is.

> Most of the configuration seems to pertain to voltage selection and

So what makes you say there's no API for any of this then?  Clearly
setting voltages is something that's supported.

> making regulators valid. I assume this means you can enable them via
> their own registers and the enablement will take hold. This seems

Please be more specific, frankly I'm having a really hard time working
out what the above means.  Obviously most of what drivers do involves
writing to registers...

> like pretty routine stuff as far as regulator configuration goes.

Which seems like a very good reason why it shouldn't just be done by a
magic sequence of undocumented register writes.
