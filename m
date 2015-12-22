From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 22 Dec 2015 11:25:41 -0800
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <566FDF53.3030004@sigmadesigns.com> (Marc Gonzalez's message of
 "Tue, 15 Dec 2015 10:37:23 +0100")
References: <566FDF53.3030004@sigmadesigns.com>
Message-ID: <7hr3iexp3e.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:

> "One more time. We're gonna celebrate."
>
> Changes since v10:
> Add aliases and chosen DT nodes
> Use CPU_CLK and SYS_CLK symbolic names
> MPCore private memory region DT node
> select TANGO_IRQ instead of GENERIC_IRQ_CHIP
>
> Changes planned for a future patch series:
> Have clkgen driver export CD2 for USB, and CD6 for SDIO

Was it intentional to leave out a multi_v7_defconfig change so that this
actually builds?  Or was that planned for a future series?

IMO, it should be part of this series so it gets build tested as soon as
it's merged.

Otherwise, looking good to me.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin
