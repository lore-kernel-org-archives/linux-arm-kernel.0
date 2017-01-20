From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 20 Jan 2017 04:02:46 +0100
Subject: [PATCH V11 0/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <CAJZ5v0i_wcnF3xM5_imEGdKW91ggUfCWCcjP-WNK-oMvO-KXMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 3:34 AM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>
> The first patch prevents the ACPI core from attempting to map IRQ resources
> with a valid ResourceSource as GSIs.
>
> The second patch adds support for ResourceSource/IRQ domain mapping and
> fixes IRQ probe deferral by allowing platform_device IRQ resources to be
> re-initialized from the corresponding ACPI IRQ resource.
>
> Both changes described above are conditional on the ACPI_GENERIC_GSI config.
>
> The third patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
>
> Tested on top of v4.10-rc4.
>
> Changes V10 -> V11:
> * Add probe table and use it to implement driver presence detection.
> * Fix kernel doc formatting in drivers/acpi/irq.c and some minor style issues.
> * Minor bug fixes in the driver.

I'm travelling now
(http://marc.info/?l=linux-pm&m=148410629024194&w=2), but I'll get
to this when I'm back.

Thanks,
Rafael
