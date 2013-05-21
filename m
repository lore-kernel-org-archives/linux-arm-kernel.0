From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 21 May 2013 17:23:46 +0530
Subject: [PATCH 6/6] ARM: OMAP2+: Remove omap4 ocp2scp pdata
In-Reply-To: <20130517191803.468.32800.stgit@localhost>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191803.468.32800.stgit@localhost>
Message-ID: <519B604A.9040300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 18 May 2013 12:48 AM, Tony Lindgren wrote:
> This is omap4+ only and no longer needed as omap4+ can be booted
> using device tree.
>
> Also remove the related pdata handling from the driver and the
> now unneeded platform_data/omap_ocp2scp.h.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
