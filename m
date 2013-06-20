From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Jun 2013 22:08:48 +0800
Subject: [PATCH v2] thermal: add imx thermal driver support
In-Reply-To: <51C2F12B.2090205@ti.com>
References: <1371280241-31699-1-git-send-email-shawn.guo@linaro.org>
 <51C0C8D8.5090301@ti.com>
 <20130619073739.GA3280@S2101-09.ap.freescale.net>
 <51C1BA1A.5010704@ti.com>
 <20130620024749.GB19896@S2101-09.ap.freescale.net>
 <51C2F12B.2090205@ti.com>
Message-ID: <20130620140846.GH19896@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 08:10:19AM -0400, Eduardo Valentin wrote:
> Well, I think just mentioning IMX6DQRM should be ok. I didnt really mean
> you need to put a link.
> 
Ok, will mention SoC Reference Manual in there.

<snip>

> Ok. If you dont care about the overhead, it is fine, as it is your call
> to design the driver accessors. FYI, this is a nice explanation of what
> is my concern:
> http://www.spinics.net/lists/linux-omap/msg92370.html
> 
Thanks for the pointer.  As the IO access here is not on the hot path
and is only at second basis, I'm not so concerned by the overhead.

Shawn
