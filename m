From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 4 Sep 2009 12:19:12 -0700
Subject: [PATCH] OMAP4: MMC driver support on OMAP4
In-Reply-To: <34590.192.168.10.89.1251897876.squirrel@dbdmail.itg.ti.com>
References: <34590.192.168.10.89.1251897876.squirrel@dbdmail.itg.ti.com>
Message-ID: <20090904121912.4b4e2b5a.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Sep 2009 18:54:36 +0530 (IST)
"kishore kadiyala" <kishore.kadiyala@ti.com> wrote:

> This Patch adds basic support for all 5 MMC controllers on OMAP4.
> 
> -Kishore
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
> This patch doesn't include mmc-regulator support
> 
>  arch/arm/mach-omap2/devices.c          |   42 +++++++++++++++++++++++++++++----
>  arch/arm/plat-omap/include/mach/irqs.h |    2 +
>  arch/arm/plat-omap/include/mach/mmc.h  |    9 ++++++-
>  drivers/mmc/host/Kconfig               |    6 ++--
>  drivers/mmc/host/omap_hsmmc.c          |   10 +++++++
>  5 files changed, 60 insertions(+), 9 deletions(-)

This looks like an ARM patch more than an MMC patch.  I grabbed it as
an MMC thing but hopefully someone else will grab it for a more
appropriate tree.
