From: davem@davemloft.net (David Miller)
Date: Wed, 15 Jun 2016 22:06:48 -0700 (PDT)
Subject: [PATCH v2 09/11] net: skfb: remove obsolete -I cflag
In-Reply-To: <20160615154553.3177021-10-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
 <20160615154553.3177021-10-arnd@arndb.de>
Message-ID: <20160615.220648.2135362761704622234.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Jun 2016 17:45:51 +0200

> The skfp driver has been moved to drivers/net/fddi/skfp a long time
> ago, but we still attempt to include headers from the old location,
> which causes a warning when building with W=1:
> 
> cc1: error: /git/arm-soc/drivers/net/skfp: No such file or directory [-Werror=missing-include-dirs]
> cc1: error: drivers/net/skfp: No such file or directory [-Werror=missing-include-dirs]
> 
> Clearly this include directive is not needed any more, so we can
> just remove it now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
