From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 6 Dec 2017 15:11:30 -0800
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20171206072402.11694-4-o.rempel@pengutronix.de>
References: <20171206072402.11694-1-o.rempel@pengutronix.de>
 <20171206072402.11694-4-o.rempel@pengutronix.de>
Message-ID: <20171206231130.GA6235@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  void (*pm_power_off_prepare)(void);
> +EXPORT_SYMBOL(pm_power_off_prepare);

EXPORT_SYMBOL_GPL for something this deeply internal, please.
