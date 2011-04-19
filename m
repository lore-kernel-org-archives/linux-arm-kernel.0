From: avictor.za@gmail.com (Andrew Victor)
Date: Tue, 19 Apr 2011 17:33:01 +0200
Subject: [PATCH] ARM: at91: AT91CAP9 has a macb device
In-Reply-To: <1303201280-25413-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1303201280-25413-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <BANLkTi=jp+acvBUR3PxkkZ4ZM613Xrg9uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> commit
>
> ? ? ? ?ee621dd (net: atmel_macb Kconfig: remove long dependency line)
>
> replaced a list of several explicit machines in the dependencies of MACB by
> a single symbol that is selected by the respective machines. ee621dd missed
> to let ARCH_AT91CAP9 select HAVE_NET_MACB though which is fixed here.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Andrew Victor <linux@maxim.org.za>
