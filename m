From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 05 Aug 2013 12:37:40 +0100
Subject: [PATCH] drivers: CCI: add ARM CCI PMU support
In-Reply-To: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
References: <1374571176-11584-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <51FF8E84.7000108@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 23/07/13 10:19, Punit Agrawal wrote:
> The CCI PMU can profile bus transactions at the master and slave
> interfaces of the CCI. The PMU can be used to observe an aggregated view
> of the bus traffic between the various components connected to the CCI.
>
> Extend the existing CCI driver to support the PMU by registering a perf
> backend for it.
>
> Document the device tree binding to describe the CCI PMU.
>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> ---
>   Documentation/devicetree/bindings/arm/cci.txt |   38 ++
>   drivers/bus/arm-cci.c                         |  642 +++++++++++++++++++++++++
>   2 files changed, 680 insertions(+)
>

It's been 2 rc's since this patch was posted. If there are no objections 
would you be ok to take this patch via your tree?

Thanks,
Punit
