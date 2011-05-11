From: avictor.za@gmail.com (Andrew Victor)
Date: Wed, 11 May 2011 09:32:00 +0200
Subject: AT91: Remove fixed mapping for AT91RM9200 ethernet
In-Reply-To: <20110511034901.GA22009@game.jcrosoft.org>
References: <1304884489.6089.13.camel@redbox>
	<20110511034901.GA22009@game.jcrosoft.org>
Message-ID: <BANLkTiks8f_BYPqTRY6XwEZiJxnFrTxW6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Jean-Christophe,

> we need to pass the irq too as the hw ip does not belong to Atmel
> so it can be attached to any irq

The IRQ is already passed via platform_resources.
The above patch also does:
   dev->irq = platform_get_irq(pdev, 0);


Regards,
  Andrew Victor
