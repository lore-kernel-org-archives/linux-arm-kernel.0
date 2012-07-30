From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 16:07:54 +0100
Subject: [PATCH 01/18] Documentation: Describe the ux500 realated audio
 related DT nodes
In-Reply-To: <50169AE8.4020601@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
 <20120729203106.GD4384@opensource.wolfsonmicro.com>
 <50163A09.8060203@linaro.org>
 <20120730134804.GE4468@opensource.wolfsonmicro.com>
 <50169AE8.4020601@linaro.org>
Message-ID: <20120730150753.GH4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 03:32:08PM +0100, Lee Jones wrote:
> On 30/07/12 14:48, Mark Brown wrote:

> >Which is part of the problem here, it makes it much harder to tell what
> >you need to do for the individual devices.

> Once again, I'll split them out, but I think there are people
> talking about documentation consolidation, as it's going to become
> very messy, very quickly if we keep adding new files for each
> device. Soon the Documentation directory will be as large as the
> driver base. :)

Well, that's device tree for you.  You can probably get away with a
single document if there's no differences but as soon as you get into
anything where you've got custom properties and no overlap you need to
start splitting things out.
