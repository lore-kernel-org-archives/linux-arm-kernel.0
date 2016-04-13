From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 13 Apr 2016 17:50:42 +0800
Subject: [PATCH v6 04/10] irqchip/gic-v2: Parse and export virtual GIC
 information
In-Reply-To: <1460388780-914-5-git-send-email-julien.grall@arm.com>
References: <1460388780-914-1-git-send-email-julien.grall@arm.com>
 <1460388780-914-5-git-send-email-julien.grall@arm.com>
Message-ID: <570E1672.5060900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/4/11 23:32, Julien Grall wrote:
> For now, the firmware tables are parsed 2 times: once in the GIC
> drivers, the other timer when initializing the vGIC. It means code
> duplication and make more tedious to add the support for another
> firmware table (like ACPI).
>
> Introduce a new structure and set of helpers to get/set the virtual GIC
> information. Also fill up the structure for GICv2.
>
> Signed-off-by: Julien Grall <julien.grall@arm.com>

For ACPI code,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
