From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 9 Sep 2014 13:05:53 +0200
Subject: [PATCH v7] ethernet: arc: Add support for Rockchip SoC layer
 device tree bindings
In-Reply-To: <1410257727-22497-1-git-send-email-romain.perier@gmail.com>
References: <1410257727-22497-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20140909110553.GA23188@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 10:15:27AM +0000, Romain Perier wrote:
> This patch defines a platform glue layer for Rockchip SoCs which
> support arc-emac driver. It ensures that regulator for the rmii is on
> before trying to connect to the ethernet controller. It applies right
> speed and mode changes to the grf when ethernet settings change.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---
>  drivers/net/ethernet/arc/Kconfig         |  10 ++
>  drivers/net/ethernet/arc/Makefile        |   1 +
>  drivers/net/ethernet/arc/emac.h          |   4 +-
>  drivers/net/ethernet/arc/emac_main.c     |   2 +
>  drivers/net/ethernet/arc/emac_rockchip.c | 229 +++++++++++++++++++++++++++++++
>  5 files changed, 245 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/arc/emac_rockchip.c

Tested-by: Beniamino Galvani <b.galvani@gmail.com>
