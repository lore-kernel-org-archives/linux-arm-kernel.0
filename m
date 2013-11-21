From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Thu, 21 Nov 2013 09:03:15 +0100
Subject: [PATCHv9][ 1/3] Input: tsc2007: Add device tree support.
In-Reply-To: <20131121050544.GE18477@ns203013.ovh.net>
References: <1383916659-9988-1-git-send-email-denis@eukrea.com>
 <20131121050544.GE18477@ns203013.ovh.net>
Message-ID: <20131121090315.298a4a14@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean Christophe,

Le Thu, 21 Nov 2013 06:05:44 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :
> > +Optional properties:
> > +- gpios: the interrupt gpio the chip is connected to (trough the penirq pin).
> nack use interrupt property this a non-sense that we do today to pass irq via
> gpio property the should NEVER known it's a gpio just an irq

read previous email and you will see the GPIO is used to get the signal
level on the pin and not the IRQ.

Eric
