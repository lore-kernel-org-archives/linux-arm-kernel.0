From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Dec 2011 08:24:23 +0000
Subject: [RFC V1 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <4EEA415F.8030901@calxeda.com>
References: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
 <4EEA415F.8030901@calxeda.com>
Message-ID: <20111216082423.GM14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 12:50:07PM -0600, Mark Langsdorf wrote:
> I'd prefer to see clk_get90 replaced with of_clk_get() and
> get_this_cpu_node() from the clk-cpufreq driver by Jamie Iles that
> I resubmitted yesterday.

Why isn't of_clk_get() hidden inside clk_get() ?
