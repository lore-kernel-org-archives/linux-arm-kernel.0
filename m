From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 5 Sep 2012 22:18:50 +0200
Subject: [PATCH v3 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120905135937.GA2362@S2101-09.ap.freescale.net>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <201209051538.12916.rjw@sisk.pl>
 <20120905135937.GA2362@S2101-09.ap.freescale.net>
Message-ID: <201209052218.50634.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 05, 2012, Shawn Guo wrote:
> On Wed, Sep 05, 2012 at 03:38:12PM +0200, Rafael J. Wysocki wrote:
> > Well, what about actually avoiding the code duplication?  That is,
> > can you make OMAP be a user of your new core function and drop the
> > OMAP-specific one, perhaps?
> > 
> I would expect that the driver will replace the omap-cpufreq driver
> completely at some point, where omap becomes a DT only platform.

That's fine, but why do we need two almost identical functions to start with?

Rafael
