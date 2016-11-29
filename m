From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Nov 2016 20:14:41 +0800
Subject: [PATCH v9 08/16] drivers: acpi: iort: add node match function
In-Reply-To: <20161121100148.24769-9-lorenzo.pieralisi@arm.com>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-9-lorenzo.pieralisi@arm.com>
Message-ID: <07ed6a31-c791-8832-530c-42ac58806848@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> Device drivers (eg ARM SMMU) need to know if a specific component
> is part of the IORT table, so that kernel data structures are not
> initialized at initcalls time if the respective component is not
> part of the IORT table.
>
> To this end, this patch adds a trivial function that allows detecting
> if a given IORT node type is present or not in the ACPI table, providing
> an ACPI IORT equivalent for of_find_matching_node().
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
