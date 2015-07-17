From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 17 Jul 2015 18:09:59 -0500
Subject: [Linaro-acpi] [PATCH v3 0/8] Add self-probe infrastructure and
 stacked irqdomain support for ACPI based GICv2/3 init
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <CAOZdJXXxJxxc9KAQK1VY9iTTVdj-FbpFpoWcexGMrqOS0TgDEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 5:45 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> This patch set introduce self-probe infrastructure to init IRQ
> controllers and stacked irqdomain support for ACPI based GICv2/3
> init.
>
> This patch set add its support for GIC verion which is introduced
> in ACPI 6.0, based on that, we introduce the self-probe infrastructure,
> the self-probe infrastructure for ACPI GIC init is similar as
> IRQCHIP_DECLARE() and based on the GIC version support in ACPI
> MADT table. we match the GIC version and GIC driver and load
> it.
>
> After the self-probe infrastructure is ready, I cleanuped the GICv2
> code to use the framework.
>
> Patch 4 implement the stacked irqdomain support for GICv2 based on
> the model of mapping interrupt and device in ACPI.
>
> Patch 5~8 are ACPI based GICv3 init.

All eight patches:

Tested-by: Timur Tabi <timur@codeaurora.org>
