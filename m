From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 11 Apr 2016 10:47:51 +0800
Subject: [PATCH v5 3/9] irqchip/gic-v2: Gather ACPI specific data in a
 single structure
In-Reply-To: <1459769860-6629-4-git-send-email-julien.grall@arm.com>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-4-git-send-email-julien.grall@arm.com>
Message-ID: <570B1057.2080902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On 2016/4/4 19:37, Julien Grall wrote:
> The ACPI code requires to use global variables in order to collect
> information from the tables.
>
> For now, a single global variable is used, but more will be added in a
> subsequent patch. To make clear they are ACPI specific, gather all the
> information in a single structure.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Acked-by: Christofer Dall <christoffer.dall@linaro.org>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Please cc me if you have further versions, I would
like to review the ARM64 ACPI related code.

Thanks
Hanjun
