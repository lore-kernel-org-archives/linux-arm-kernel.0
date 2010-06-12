From: david-b@pacbell.net (David Brownell)
Date: Sat, 12 Jun 2010 07:24:30 -0700 (PDT)
Subject: [PATCH 4/5] [ARM] usb/host/ohci-pxa27x: make PXA310 USB OTG port
	work in host mode.
In-Reply-To: <AANLkTilUt8D7B3UF_j1wOvsnXTVQyioofwMEikScdLOn@mail.gmail.com>
Message-ID: <614940.91741.qm@web180314.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Sat, 6/12/10, Eric Miao <eric.y.miao@gmail.com> wrote:

> > ?arch/arm/mach-pxa/include/mach/ohci.h ? ? | ? ?3
> +
> > ?arch/arm/mach-pxa/include/mach/regs-u2d.h | ? ?2
> +
> > ?drivers/usb/host/ohci-pxa27x.c ? ? ? ? ? ?|
> ?183 +++++++++++++++++++++++++++++

Doesn't touch generic OHCI code, so it looks
OK to me... ack.
> 
> My feeling is on pxa310, the OTG/ULPI is actually closer to
> the UDC, so
> generally, I'd really like to see minimum change to ohci.
> 
