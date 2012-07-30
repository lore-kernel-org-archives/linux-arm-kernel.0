From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 19:55:01 +0100
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120730082052.GD31509@S2101-09.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120726131121.GB7306@sirena.org.uk>
 <20120730065218.GB31509@S2101-09.ap.freescale.net>
 <20120730082052.GD31509@S2101-09.ap.freescale.net>
Message-ID: <20120730185501.GU4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:20:54PM +0800, Shawn Guo wrote:
> On Mon, Jul 30, 2012 at 02:52:20PM +0800, Shawn Guo wrote:

> > Ok, makes sense to me.

> In the reply to one of Richard's comment, the volt_old will be used
> not only for diagnostic purpose but also for reverting voltage back
> when clk_set_rate fails.

We should be able to figure out what operating point we set without
having to read it back from the hardware like this.
