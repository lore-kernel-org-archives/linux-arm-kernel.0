From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 22 Sep 2015 12:37:03 +0200 (CEST)
Subject: [tip:irq/urgent] irqchip/atmel-aic5: Use proper mask cache in
 mask/unmask()
In-Reply-To: <tip-478cc7b33413a4ad50852239d931d55e622f1cde@git.kernel.org>
References: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
 <tip-478cc7b33413a4ad50852239d931d55e622f1cde@git.kernel.org>
Message-ID: <alpine.DEB.2.11.1509221236220.5606@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Sep 2015, tip-bot for Ludovic Desroches wrote:

> Commit-ID:  478cc7b33413a4ad50852239d931d55e622f1cde
> Gitweb:     http://git.kernel.org/tip/478cc7b33413a4ad50852239d931d55e622f1cde

FYI, I zapped that commit again after noticing that locking
strangeness.

Thanks,

	tglx
