From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 19:28:18 +0100
Subject: [PATCH v3 1/5] i2c: i2c-davinci: switch to use platform_get_irq
In-Reply-To: <1417448047-15236-2-git-send-email-grygorii.strashko@ti.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-2-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20141204182818.GF7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:34:03PM +0200, Grygorii Strashko wrote:
> Switch Davinci I2C driver to use platform_get_irq(), because
> it is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ, ..)
> for requesting IRQ resources any more, as they can be not ready yet
> in case of DT-boot.
> 
> CC: Sekhar Nori <nsekhar@ti.com>
> CC: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/636a78ce/attachment.sig>
