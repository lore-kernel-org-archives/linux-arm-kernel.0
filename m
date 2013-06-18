From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 18 Jun 2013 15:41:04 +0200
Subject: [PATCH] ARM: irqchip: add support for MOXA ART SoCs
In-Reply-To: <1371549584-7169-1-git-send-email-jonas.jensen@gmail.com>
References: <1371549584-7169-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130618154104.7f8115c7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jonas Jensen,

On Tue, 18 Jun 2013 11:59:44 +0200, Jonas Jensen wrote:

> +asmlinkage void __exception_irq_entry moxart_handle_irq(struct pt_regs *regs);

This forward declaration could be removed if moxart_handle_irq() was
implemented before the initialization function of your driver.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
