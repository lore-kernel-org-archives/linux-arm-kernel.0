From: davem@davemloft.net (David Miller)
Date: Fri, 05 Sep 2014 15:10:32 -0700 (PDT)
Subject: [PATCH v5 1/4] ethernet: arc: Add support for Rockchip SoC
 layer device tree bindings
In-Reply-To: <1409763165-16461-1-git-send-email-romain.perier@gmail.com>
References: <1409763165-16461-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20140905.151032.2294854942425937456.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Romain Perier <romain.perier@gmail.com>
Date: Wed,  3 Sep 2014 16:52:42 +0000

> This patch defines a platform glue layer for Rockchip SoCs which
> support arc-emac driver. It ensures that regulator for the rmii is on
> before trying to connect to the ethernet controller. It applies right
> speed and mode changes to the grf when ethernet settings change.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

You'll need to resubmit this series with the Kconfig warnings fixed.
