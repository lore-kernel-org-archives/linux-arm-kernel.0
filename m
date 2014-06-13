From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 13 Jun 2014 12:23:50 -0400
Subject: [PATCH 03/14] ARM: keystone requires ARM_PATCH_PHYS_VIRT
In-Reply-To: <1402675276-538682-4-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
 <1402675276-538682-4-git-send-email-arnd@arndb.de>
Message-ID: <539B2596.8030202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 June 2014 12:01 PM, Arnd Bergmann wrote:
> The dynamic relocation that the keystone platform performs
> only works if we can pick the phys offset at boot time. It's
> possible that there is another solution for this, but this
> is the easiest workaround. Kernels with ARM_PATCH_PHYS_VIRT
> are not portable across platforms, and I see no reason why
> anyone would run a kernel without ARM_PATCH_PHYS_VIRT on
> keystone.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
Agree.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
