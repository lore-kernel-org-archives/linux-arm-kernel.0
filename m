From: olof@lixom.net (Olof Johansson)
Date: Mon, 11 Nov 2013 11:35:26 -0800
Subject: [PATCH v4 2/4] ARM: make mach-xyz/Makefile.boot optional for
 !ARCH_MULTIPLATFORM
In-Reply-To: <1383562853-17202-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20131104105836.GI14892@pengutronix.de>
 <1383562853-17202-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131111193526.GA12278@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 12:00:51PM +0100, Uwe Kleine-K?nig wrote:
> Makefile.boot is supposed to define zreladdr-y, params_phys-y and
> initrd_phys-y. The first one is only needed in the absence of AUTO_ZRELADDR
> and when building a zImage. The latters are only needed for bootp stuff.
> So ignore errors on including Makefile.boot and error out in the targets
> that need the corresponding settings.
> 
> This makes it unnecessary to create dummy Makefile.boot files.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Olof Johansson <olof@lixom.net>

Please send it to Russell's patch tracker.


-Olof
