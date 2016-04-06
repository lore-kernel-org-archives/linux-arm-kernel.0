From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Apr 2016 19:26:20 +0200
Subject: [PATCH v5 5/9] irqchip/gic-v3: Gather all ACPI specific data in
 a single structure
In-Reply-To: <1459769860-6629-6-git-send-email-julien.grall@arm.com>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <1459769860-6629-6-git-send-email-julien.grall@arm.com>
Message-ID: <20160406172620.GI8961@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 12:37:36PM +0100, Julien Grall wrote:
> The ACPI code requires to use global variales in order to collect

s/variales/variables/

> information from the tables.
> 
> To make clear those variables are ACPI specific, gather all of them in a
> single structure.
> 
> Furthermore, even if some of the variables are not marked with
> __initdata, they are all only used during the initialization. Therefore,
> the new variable, which hold the structure, can be marked with
> __initdata.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> 
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> 
>     Changes in v4:
>         - Rework commit message
> 
>     Changes in v3:
>         - Patch added
> ---

Otherwise:
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
