From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 7 Sep 2015 00:08:26 +0200 (CEST)
Subject: [RFC PATCH v1 1/4] genirq: Introduce
 irq_settings_set_move_pcntxt() helper
In-Reply-To: <1441513421-8092-2-git-send-email-yangyingliang@huawei.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
 <1441513421-8092-2-git-send-email-yangyingliang@huawei.com>
Message-ID: <alpine.DEB.2.11.1509070007310.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Sep 2015, Yang Yingliang wrote:

> It's expected to use the helper when interrupt can be moved
> in process.

What's wrong with using the existing helper?

       irq_set_status_flags(irq, IRQ_MOVE_PCNTXT);

Thanks,

	tglx
