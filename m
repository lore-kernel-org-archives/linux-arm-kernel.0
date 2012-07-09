From: davem@davemloft.net (David Miller)
Date: Mon, 09 Jul 2012 00:03:26 -0700 (PDT)
Subject: [PATCH] net/macb: manage carrier state with call to
 netif_carrier_{on|off}()
In-Reply-To: <1341393253-6531-1-git-send-email-nicolas.ferre@atmel.com>
References: <1341361835.2839.21.camel@bwh-desktop.uk.solarflarecom.com>
 <1341393253-6531-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120709.000326.1862834306569616029.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 4 Jul 2012 11:14:13 +0200

> OFF carrier state is setup in probe() open() and suspend() functions.
> The carrier ON state is managed in macb_handle_link_change().
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied to net-next, thanks.
