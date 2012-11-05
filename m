From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Nov 2012 11:13:51 -0500 (EST)
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121105153917.GG28327@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net> <20121105104839.GA2005@linaro.org>
 <20121105111346.GF28327@n2100.arm.linux.org.uk>
 <20121105130255.GD2005@linaro.org>
 <20121105153917.GG28327@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1211051111150.21033@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Nov 2012, Russell King - ARM Linux wrote:

> On Mon, Nov 05, 2012 at 01:02:55PM +0000, Dave Martin wrote:
> > Why not allow unaligned accesses in the decompressor, though, both
> > for v6 and v7?
> 
> EXACTLY.

I have no objections to that.  In fact, I made a remark to this effect 
in my initial review of this patch.  Whether or not gcc does take 
advantage of this hardware ability in the end is orthogonal.


Nicolas
