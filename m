From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 21:59:40 +0800
Subject: [PATCH v3 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <201209051538.12916.rjw@sisk.pl>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <201209050118.39045.rjw@sisk.pl>
 <20120905011219.GN2362@S2101-09.ap.freescale.net>
 <201209051538.12916.rjw@sisk.pl>
Message-ID: <20120905135937.GA2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 03:38:12PM +0200, Rafael J. Wysocki wrote:
> Well, what about actually avoiding the code duplication?  That is,
> can you make OMAP be a user of your new core function and drop the
> OMAP-specific one, perhaps?
> 
I would expect that the driver will replace the omap-cpufreq driver
completely at some point, where omap becomes a DT only platform.

-- 
Regards,
Shawn
