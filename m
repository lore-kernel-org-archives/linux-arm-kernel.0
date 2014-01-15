From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 14:48:13 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a gpio
 used as an interrupt source.
In-Reply-To: <CACh+v5Mccz47VMxDcrAC1NY30cY53gxEmp5MG4+n0PNn5RrsSw@mail.gmail.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <20140115132035.GE9558@ns203013.ovh.net>
 <CACh+v5Mccz47VMxDcrAC1NY30cY53gxEmp5MG4+n0PNn5RrsSw@mail.gmail.com>
Message-ID: <8007592.fj8kc2EY8M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 14:44:24 Jean-Jacques Hiblot wrote:
> 2014/1/15 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> > On 14:04 Wed 15 Jan     , Jean-Jacques Hiblot wrote:
> >> 2014/1/15 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
> >> > because this the only to start to do it right
> >> > I had a very long discussion woth LinusW and Grant the Gpio need to stop to
> >> > use gpio_to_irq & co for irq.
> >> How can you get the value of the gpio that is also an interrupt source then ?
> >> Can you give a short example?
> >
> > you just have to check the irq source
> >
> > failing or raising
> >
> > but on 9261 impossible the gpio does not have such detail
> >
> > but anyway this is the invert you need to get the information from the IRQ no the way
> > arround
> 
> Should I modify the touchscreen driver to use irq_to_gpio() in this
> case then ? or is this also not proper ?

irq_to_gpio no longer exists.

	Arnd
