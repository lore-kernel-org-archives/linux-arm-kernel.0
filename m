From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 20:17:37 +0200
Subject: [PATCH v5 1/4] ethernet: arc: Add support for Rockchip SoC layer
 device tree bindings
In-Reply-To: <1409763165-16461-1-git-send-email-romain.perier@gmail.com>
References: <1409763165-16461-1-git-send-email-romain.perier@gmail.com>
Message-ID: <8915336.1DB5xPOmil@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 16:52:42 Romain Perier wrote:
> This patch defines a platform glue layer for Rockchip SoCs which
> support arc-emac driver. It ensures that regulator for the rmii is on
> before trying to connect to the ethernet controller. It applies right
> speed and mode changes to the grf when ethernet settings change.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> 

Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
