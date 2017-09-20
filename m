From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 20 Sep 2017 09:08:46 +0200
Subject: [PATCH] pinctrl: bcm2835: fix build warning in
 bcm2835_gpio_irq_handle_bank
In-Reply-To: <20170919190456.26522-1-clabbe.montjoie@gmail.com>
References: <20170919190456.26522-1-clabbe.montjoie@gmail.com>
Message-ID: <07247a0f-f933-3655-4469-6090fe91f8b5@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 19.09.2017 um 21:04 schrieb Corentin Labbe:
> This patch fix the following build warning:
> drivers/pinctrl/bcm/pinctrl-bcm2835.c:376:15: warning: variable 'type' set but not used [-Wunused-but-set-variable]
>
> Furthermore, it is unused for a long time, at least since commit 85ae9e512f43 ("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")
> where a "FIXME no clue why the code looks up the type here" was added.
> A year after, nobody answeered this question, so its time to remove it.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
