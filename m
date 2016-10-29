From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Sat, 29 Oct 2016 15:08:34 +0200
Subject: Low network throughput on i.MX28
In-Reply-To: <1143135945.89173.6f7a3a9a-5120-4cc2-a76b-92a516ab6500.open-xchange@email.1und1.de>
References: <1476313753.2065.11.camel@embedded.rocks>
 <20161013084807.6a231fdb@ipc1.ka-ro>
 <A57BCA39-0977-43C4-B22D-ED60F5E4B06D@embedded.rocks>
 <20161014081349.1afb22c6@ipc1.ka-ro>
 <1476521171.1670.2.camel@embedded.rocks>
 <2131339088.8778.d47a56f6-921e-4d6c-9a5c-2e77bfd5d281.open-xchange@email.1und1.de>
 <8C3BD5BA-252F-4A95-B938-50356A23974E@embedded.rocks>
 <2003579366.391192.0cc5acd0-af27-4ef7-892f-3c2dd86176ba.open-xchange@email.1und1.de>
 <1477696028.31471.3.camel@embedded.rocks>
 <1143135945.89173.6f7a3a9a-5120-4cc2-a76b-92a516ab6500.open-xchange@email.1und1.de>
Message-ID: <1477746514.13850.1.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-10-29 at 11:08 +0200, Stefan Wahren wrote:
> > J?rg Krause <joerg.krause@embedded.rocks> hat am 29. Oktober 2016
> > um 01:07
> > geschrieben:
> > 
> > 
> > You mentioned [1] an optimization in the Freescale vendor Linux
> > kernel
> > [2]. I would really like to see this optimization in the mainline
> > kernel.
> > 
> > Did you ever tried to port this code from Freescale to mainline?
> 
> Yes, i tried once but i was frustrated soon because of the lot of
> required
> changes and resulting issues.

I can imagine.

> > 
> > Is it even possible, as the mainline driver uses the DMA engine?
> 
> I think the more important part would be analyse why the Mainline
> driver is
> slowlier. I mean to exactly identify the bottleneck.

I'll try to understand the driver implementation. However, I am not a
Linux kernel developer, so this will need some time for sure. Any help
will be appreciated!

> I don't have enough time and equipment for this. I better concentrate
> on standby
> support.

Many thanks for your work!

J?rg
