From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 14:42:21 +0100
Subject: [PATCH 17/18] ARM: ux500: Add all encompassing Sound node to
 DB8500 Device Tree
In-Reply-To: <50163936.1050901@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-18-git-send-email-lee.jones@linaro.org>
 <20120729205227.GL4384@opensource.wolfsonmicro.com>
 <50163936.1050901@linaro.org>
Message-ID: <20120730134220.GD4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 08:35:18AM +0100, Lee Jones wrote:
> On 29/07/12 21:52, Mark Brown wrote:

> >...this is clearly the board-specific setup for the system, showing how
> >the CPU and CODEC are hooked up.  This should therefore be in the DT for
> >whatever board this is you're working on.

> I don't think it's board specific. I believe this is the setup on
> all db8500 platforms. I'm happy to be told I'm wrong here, in which
> case I can move it to the board specific files.

I think that's more a sign that all the platforms you've seen are just
cut'n'pasted from the reference design than anything else.  If the thing
you're describing is on the PCB it's generally board specific...
