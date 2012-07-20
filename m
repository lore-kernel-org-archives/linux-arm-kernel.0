From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jul 2012 21:15:55 +0800
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <d9889f8c-cebd-482d-af5c-c9e207c3dfae@email.android.com>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <d9889f8c-cebd-482d-af5c-c9e207c3dfae@email.android.com>
Message-ID: <20120720131554.GB32263@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 08:51:17PM +0800, Richard Zhao wrote:
> Hi, Shawn,
> 
> I find you create a new driver rather than work on my generic cpufreq driver based on clk and regulator.
> Is there any reason besides adding opp support?
> 
Adopting OPP support forces me to look at omap-cpufreq driver, hence
makes me create a new driver by referencing to omap-cpufreq.

-- 
Regards,
Shawn
