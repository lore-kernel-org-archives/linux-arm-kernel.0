From: santosh.shilimkar@gmail.com (Santosh Shilimkar)
Date: Wed, 29 Oct 2014 11:57:49 -0700
Subject: [PATCH v1 1/4] ARM: keystone: add pcie related options
In-Reply-To: <1414601134-31825-2-git-send-email-m-karicheri2@ti.com>
References: <1414601134-31825-1-git-send-email-m-karicheri2@ti.com>
 <1414601134-31825-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <545138AD.5090307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2014 09:45 AM, Murali Karicheri wrote:
> Now that Keystone PCI controller is merged, add pcie related options
> by default for keystone architecture so that driver can be enabled in
> the build.
>
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> ---
>   - v1 - No change w.r.t
>   arch/arm/mach-keystone/Kconfig |    2 ++
>   1 file changed, 2 insertions(+)
>
Looks good. Will pick this up for next merge window.

Regards,
Santosh
