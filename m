From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 09 Jul 2012 22:34:37 +0200
Subject: [PATCH 7/9] Input: ab8500-ponkey: Create AB8500 domain IRQ mapping
In-Reply-To: <20120709201422.GA12242@core.coreip.homeip.net>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <4FF6994B.9040801@linaro.org> <20120706173957.GA10202@core.coreip.homeip.net>
 <4FFB288D.4080606@linaro.org> <20120709201422.GA12242@core.coreip.homeip.net>
Message-ID: <4FFB405D.6070300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Why do you keep these assignments and then override them with
> translations? Why don't you do
>
> 	ponkey->idev = input;
> 	ponkey->ab8500 = ab8500;
> 	ponkey->irq_dbf = ab8500_irq_get_virq(ab8500, irq_dbf);
> 	ponkey->irq_dbr = ab8500_irq_get_virq(ab8500, irq_dbr);
>
> to begin with?

Ah, I see what you mean now.

Sorry, just glossed over your first email.
