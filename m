From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Feb 2014 14:33:49 +0800
Subject: [GIT PULL] ARM: imx: device tree changes for 3.15, take 1
In-Reply-To: <4771497.sfdTTRjnSv@phil>
References: <20140205122258.GA13821@S2101-09.ap.freescale.net>
 <4771497.sfdTTRjnSv@phil>
Message-ID: <20140210063347.GK9628@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 11:04:30AM +0100, Heiko St?bner wrote:
> Hi Shawn,
> 
> Am Mittwoch, 5. Februar 2014, 20:23:01 schrieb Shawn Guo:
> >  - Make pinctrl nodes board specific to avoid floating board specific
> >    device tree blob with so many unused pinctrl data.
> 
> can you take a look at "dtc: add ability to make nodes conditional on them 
> being referenced" [0] to see if it can help to solve the floating pinctrl 
> problem more generic in the future?

Yes, if it gets accepted, we will consider to use it in the future
projects.

Shawn

> [0] http://www.spinics.net/lists/arm-kernel/msg303967.html
> 
