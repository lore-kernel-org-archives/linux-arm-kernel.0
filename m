From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 19 Apr 2011 17:49:41 +0200
Subject: [PATCH] ARM: at91: AT91CAP9 has a macb device
In-Reply-To: <1303201280-25413-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1303201280-25413-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110419154941.GC19199@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:21 Tue 19 Apr     , Uwe Kleine-K?nig wrote:
> commit
> 
> 	ee621dd (net: atmel_macb Kconfig: remove long dependency line)
> 
> replaced a list of several explicit machines in the dependencies of MACB by
> a single symbol that is selected by the respective machines. ee621dd missed
> to let ARCH_AT91CAP9 select HAVE_NET_MACB though which is fixed here.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
