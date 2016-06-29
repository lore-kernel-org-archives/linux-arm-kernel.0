From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 29 Jun 2016 15:13:08 +0200
Subject: [PATCH V2 1/4] ACPI,PCI,IRQ: factor in PCI possible
In-Reply-To: <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
Message-ID: <CAJZ5v0j1m4oGJfdOC8uerKc-3ksq6k2e9RdjEnk0sWmsq4RHRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 10:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
> resource requirements") omitted the initially assigned POSSIBLE penalty
> when the IRQ is active.

It would be good to say what can go wrong with that here.

> The original code would assign the POSSIBLE value divided by the number
> of possible IRQs during initialization.
>
> Later, if the IRQ is chosen as the active IRQ or if the IRQ is in use
> by ISA; additional penalties get added.

Thanks,
Rafael
