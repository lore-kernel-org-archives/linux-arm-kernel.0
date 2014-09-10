From: davem@davemloft.net (David Miller)
Date: Tue, 09 Sep 2014 17:30:19 -0700 (PDT)
Subject: [PATCH v6 1/4] ethernet: arc: Add support for Rockchip SoC
 layer device tree bindings
In-Reply-To: <1410196490-5646-1-git-send-email-romain.perier@gmail.com>
References: <1410196490-5646-1-git-send-email-romain.perier@gmail.com>
Message-ID: <20140909.173019.1085874055765706579.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Romain Perier <romain.perier@gmail.com>
Date: Mon,  8 Sep 2014 17:14:47 +0000

> This patch defines a platform glue layer for Rockchip SoCs which
> support arc-emac driver. It ensures that regulator for the rmii is on
> before trying to connect to the ethernet controller. It applies right
> speed and mode changes to the grf when ethernet settings change.
> 
> Signed-off-by: Romain Perier <romain.perier@gmail.com>

Applied.
