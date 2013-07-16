From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 09:26:01 +0800
Subject: [RFC PATCH 07/11] cpufreq: cpufreq-cpu0: remove device tree
 parsing for cpu nodes
In-Reply-To: <1373883732-26303-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1373883732-26303-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130716012559.GB28375@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 11:22:08AM +0100, Sudeep.KarkadaNagesha at arm.com wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Now that the cpu device registration initialises the of_node(if available)
> appropriately for all the cpus, parsing here is redundant.
> 
> This patch removes all DT parsing and uses cpu->of_node instead.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
