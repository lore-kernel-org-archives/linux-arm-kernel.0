From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Dec 2013 10:45:48 +0800
Subject: imx6 power consumption
In-Reply-To: <E1VszO5-00060R-Gp@merlin.infradead.org>
References: <E1VszO5-00060R-Gp@merlin.infradead.org>
Message-ID: <20131218024546.GA6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 07:28:27PM +0100, Bj?rn Erik Nilsen wrote:
> Hi,
> 
> I have measured power consumption for imx6 in mem mode on the 3.12.4 mainstream kernel vs. 3.0.35 kernel from freescale/boundary devices. I noticed a significant increase going from 3.0 to 3.12 . I have at least identified one big difference: DDR is no longer tri-stated, which accounts for some of the difference.
> 
> I use 'echo mem > /sys/power/state' for my test case.
> 
> Do you know if someone is looking into this issue, or if there are pending patches somewhere?

It's an unimplemented feature rather than an issue.  There are some
patches on Freescale 3.10 kernel, and you're welcomed to bring these
patches to mainline kernel.

Shawn
