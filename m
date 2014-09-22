From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Sep 2014 17:22:22 +0200
Subject: [PATCH v2 7/8] irqchip: add irq-asm9260 driver
In-Reply-To: <1411325151-15107-6-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-6-git-send-email-linux@rempel-privat.de>
Message-ID: <2829481.qsohvqlupS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 September 2014 20:45:50 Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  drivers/irqchip/Makefile      |   1 +
>  drivers/irqchip/irq-asm9260.c | 257 ++++++++++++++++++++++++++++++++++++++++++

This driver seems to be closely related to drivers/irqchip/irq-mxs.c.
Are you perhaps able to share some or all of the code?

	Arnd
