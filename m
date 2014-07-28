From: mporter@linaro.org (Matt Porter)
Date: Mon, 28 Jul 2014 10:26:43 -0400
Subject: [PATCH v6 0/4] ARM: SMP: support Broadcom mobile SoCs
In-Reply-To: <1404166540-4457-1-git-send-email-elder@linaro.org>
References: <1404166540-4457-1-git-send-email-elder@linaro.org>
Message-ID: <20140728142643.GZ2593@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 05:15:36PM -0500, Alex Elder wrote:
> This series adds SMP support for two Broadcom mobile SoC families.
> It uses CPU_METHOD_OF_DECLARE() so that SMP operations are assigned
> using device tree rather than adding it to a machine definition in a
> board file.
> 
> The enable method starts a secondary core by writing to a register
> monitored by CPUs spinning in a ROM-based holding pen loop.  The
> address of this register is recorded as a property in the "cpus"
> node of the device tree.
> 
> 					-Alex

Applied the series to mach-bcm for-3.17/[soc|dt]

Thanks,
Matt
