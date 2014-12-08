From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 08 Dec 2014 10:14:46 -0800
Subject: [PATCH] ARM / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
In-Reply-To: <2407638.dfZGaT4vm1@vostro.rjw.lan>
References: <2407638.dfZGaT4vm1@vostro.rjw.lan>
Message-ID: <5485EA96.4000806@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/5/2014 6:50 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> depending on CONFIG_PM_RUNTIME may now be changed to depend on
> CONFIG_PM.
>
> Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere in the code under
> arch/arm/ (the defconfig files will be modified later).
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> PM_SLEEP is selected) which is only in linux-next at the moment (via the
> linux-pm tree).
>
> Please let me know if it is OK to take this one into linux-pm.
>
> ---

>   arch/arm/mach-keystone/pm_domain.c |    2 +-

Looks fine to me. For keystone parts.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
