From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2012 15:39:17 +0000
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <20121105130255.GD2005@linaro.org>
References: <alpine.LFD.2.02.1210100939160.16518@xanadu.home>
 <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net> <20121105104839.GA2005@linaro.org>
 <20121105111346.GF28327@n2100.arm.linux.org.uk>
 <20121105130255.GD2005@linaro.org>
Message-ID: <20121105153917.GG28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 01:02:55PM +0000, Dave Martin wrote:
> Why not allow unaligned accesses in the decompressor, though, both
> for v6 and v7?

EXACTLY.
