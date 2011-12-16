From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 16 Dec 2011 18:18:27 +0800
Subject: [RFC V1 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <20111216082423.GM14542@n2100.arm.linux.org.uk>
References: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
 <4EEA415F.8030901@calxeda.com>
 <20111216082423.GM14542@n2100.arm.linux.org.uk>
Message-ID: <20111216101826.GV28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2011 at 08:24:23AM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 15, 2011 at 12:50:07PM -0600, Mark Langsdorf wrote:
> > I'd prefer to see clk_get90 replaced with of_clk_get() and
> > get_this_cpu_node() from the clk-cpufreq driver by Jamie Iles that
> > I resubmitted yesterday.
> 
> Why isn't of_clk_get() hidden inside clk_get() ?
Good point.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
