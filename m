From: ido@wizery.com (Ido Yariv)
Date: Mon, 11 Jul 2011 23:33:56 +0300
Subject: [PATCH v2 1/6] arm: davinci: Fix low level gpio irq handlers'
	argument
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-2-git-send-email-ido@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
Message-ID: <20110711203356.GA5633@WorkStation>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Mon, Jul 11, 2011 at 05:28:44PM +0530, Nori, Sekhar wrote:
> Thanks for the bug fix.
> 
> How about setting the handler data for bank IRQ in
> davinci_gpio_irq_setup() to &chips[bank]?
> 
> chips[bank].regs should give you the register base address
> (g) and chips[bank].irq_base should give you 'n'.
> 
> Also please drop the rename of irq to bank_irq as it is not
> central to the bug fix.
> 
> If you spin in soon enough, we may make it to v3.0

Sure, I'll send a v3 in a few.

Thanks for the review,
Ido.
