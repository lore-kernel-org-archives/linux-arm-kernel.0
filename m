From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Sep 2013 19:19:50 +0800
Subject: [PATCH v4 12/19] cpufreq: cpufreq-cpu0: remove device tree
 parsing for cpu nodes
In-Reply-To: <522EFAD1.4020709@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <Pine.LNX.4.64.1309061539310.11068@axis700.grange>
 <522D93D7.4010307@arm.com>
 <20130909143253.GD4624@S2101-09.ap.freescale.net>
 <522DE822.3030907@arm.com>
 <20130910024404.GC5815@S2101-09.ap.freescale.net>
 <522EFAD1.4020709@arm.com>
Message-ID: <20130910111947.GH5815@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 11:56:17AM +0100, Sudeep KarkadaNagesha wrote:
> > So we only need to change all clkdev registration to use "cpu0" as
> > dev_id intstead of "cpufreq-cpu0.0", something like below.
> > 
> > And for imx, it should work even without the changes, because we have
> > device tree lookup ready there, and those clk_register_clkdev() calls
> > can just be removed now.  But I prefer to include the change and leave
> > the cleanup to another patch for keeping the change log clear.
> > 
> Ok makes sense, do you want me to include this patch also as fix.
> I can send a series to fix this if you OK:
> 1. Fix in cpufreq-cpu0
> 2. Fix in i.MX driver and platform file
> 3. Patch below

Yes, please.  Thanks.

Shawn
