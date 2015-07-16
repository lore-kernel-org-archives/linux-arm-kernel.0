From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 16 Jul 2015 20:19:08 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <CACRpkdb_3B8749X-p_XEPGvZPEQ56-gMdLBcPrgjXkqWCiz1PQ@mail.gmail.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <267A46E7-C5C5-4696-90CC-D44F4130B3EF@smart-africa.com>
 <20150702142058.GA9349@localhost.localdomain>
 <CACRpkdb_3B8749X-p_XEPGvZPEQ56-gMdLBcPrgjXkqWCiz1PQ@mail.gmail.com>
Message-ID: <20150716181908.GA27856@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 09:57:23AM +0200, Linus Walleij wrote:
> So what about making a patch to drivers/gpio/gpio-dwapb.c that adds the
> .names property to its GPIO chip?

OK, so the user knows that he wants the instance with .name = "gpio0".

What should he write into /sys/class/gpio/export?

Thanks,
Richard
