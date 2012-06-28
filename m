From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 17:09:30 +0800
Subject: [GIT PULL] imx fixes for v3.5-rc (part 2)
In-Reply-To: <CAAQ0ZWQ1D38onzk0aMaCTEQ-NSyCgEEUNwK3PfWbE2VUSG2ckQ@mail.gmail.com>
References: <20120611044359.GD2344@S2101-09.ap.freescale.net>
 <CAAQ0ZWQ1D38onzk0aMaCTEQ-NSyCgEEUNwK3PfWbE2VUSG2ckQ@mail.gmail.com>
Message-ID: <20120628090927.GB22990@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Jun 11, 2012 at 12:47:15PM +0800, Shawn Guo wrote:
> Shawn Guo (2):
>       ARM: imx6q: remove unneeded clkdev lookups

We agreed that this one is actually a cleanup and can be held off
until 3.6 ...

>       ARM: imx6q: fix suspend regression caused by common clk migration

... but this is one is indeed a fix, which seems missed from your
pull-request to Linus.

-- 
Regards,
Shawn
