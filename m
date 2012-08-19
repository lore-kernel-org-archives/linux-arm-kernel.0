From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 19 Aug 2012 23:26:58 +0800
Subject: imx6q restart is broken
In-Reply-To: <20120817034854.GE24242@S2101-09.ap.freescale.net>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809092021.GQ18957@n2100.arm.linux.org.uk>
 <502BBB43.5010403@gmail.com>
 <20120815214412.GC32560@n2100.arm.linux.org.uk>
 <20120816023109.GH2258@S2101-09.ap.freescale.net>
 <20120816223446.GB15883@n2100.arm.linux.org.uk>
 <20120817034854.GE24242@S2101-09.ap.freescale.net>
Message-ID: <20120819152656.GI24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2012 at 11:48:56AM +0800, Shawn Guo wrote:
> > I think what needs to happen here (while we wait) is someone _with_ the
> > problem needs to experiment, and find out how many nops are needed for
> > the DMB not to have much effect in cpu_relax().  If it turns out we just
> > need to put one nop in, then that's not _too_ bad.
> 
> At least, I need to have 5 nops to get rid of the issue, something like
> below.
> 
Russell,

What's your take on this then?

-- 
Regards,
Shawn
