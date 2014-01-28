From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Jan 2014 18:30:01 +0800
Subject: [PATCH 1/9] ARM: dts: imx6qdl: remove the use of pingrp macros
In-Reply-To: <20140127143745.GM15937@n2100.arm.linux.org.uk>
References: <1390668191-20289-1-git-send-email-shawn.guo@linaro.org>
 <1390668191-20289-2-git-send-email-shawn.guo@linaro.org>
 <20140127143745.GM15937@n2100.arm.linux.org.uk>
Message-ID: <20140128102959.GB20583@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 02:37:45PM +0000, Russell King - ARM Linux wrote:
> On Sun, Jan 26, 2014 at 12:43:03AM +0800, Shawn Guo wrote:
> >  arch/arm/boot/dts/imx6dl-hummingboard.dts  |    5 +-
> >  arch/arm/boot/dts/imx6qdl-microsom.dtsi    |    5 +-
> 
> I've merged your changes here into my local copy of these just to reduce
> the conflicts - unfortunately, it's taken soo long to deal with the above
> that the cubox-i has now been released, which has prompted some
> reorganisation between the above two files.
> 
> I would much rather you dropped these two entirely, and let me push them
> upstream, rather than having some nasty conflicts which result from this.

Dropped hummingboard from my tree.

Shawn
