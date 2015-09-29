From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Sep 2015 22:42:27 +0800
Subject: [PATCH v3 2/7] irqchip/acpi: Add probing infrastructure for
 ACPI-based irqchips
In-Reply-To: <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <560AA353.6040206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2015 10:49 PM, Marc Zyngier wrote:
> DT enjoys a rather nice probing infrastructure for irqchips, while
> ACPI is so far stuck into a very distant past.
>
> This patch introduces a declarative API, allowing irqchips to be
> self-contained and be called when a particular entry is matched
> in the MADT table.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
