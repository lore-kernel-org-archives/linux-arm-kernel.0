From: marex@denx.de (Marek Vasut)
Date: Thu, 14 Jun 2012 12:54:51 +0200
Subject: MXS getting AUART to work with DT.
In-Reply-To: <CAOMZO5Du8OS9pu3N9ThX39an8YXFb9fWJP9vF0GNxe_o4U6v7g@mail.gmail.com>
References: <4FD7EFFC.8010204@grid-net.com>
 <CAOMZO5AN-BUXzr0t5=hD0sNT_mJXv8kZa1JOJc8uE=p3cov1Sg@mail.gmail.com>
 <CAOMZO5Du8OS9pu3N9ThX39an8YXFb9fWJP9vF0GNxe_o4U6v7g@mail.gmail.com>
Message-ID: <201206141254.51432.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> On Wed, Jun 13, 2012 at 11:33 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Wed, Jun 13, 2012 at 10:32 PM, Marek Vasut <marex@denx.de> wrote:
> >> I think the kernel for non-DT case is already FUBAR ... just do a simple
> >> DT conversion :-(
> > 
> > So does it mean mxs-auart has never been used?
> 
> Ok, just tested a 3.4.2 (non-DT kernel) and I see:
> 
> [    0.570000] mxs-auart.0: ttyAPP0 at MMIO 0x8006a000 (irq = 112) is
> a mxs-auart.0
> [    0.580000] mxs-auart mxs-auart.0: Found APPUART 3.1.0
> [    0.590000] mxs-auart.3: ttyAPP3 at MMIO 0x80070000 (irq = 115) is
> a mxs-auart.3
> [    0.600000] mxs-auart mxs-auart.3: Found APPUART 3.1.0
> 
> ,so it means that something broke mxs-auart on 3.5-rc.

I tested it on 3.4-rc6, it worked back there with non-DT kernel.

> Will look more on this tomorrow.

Best regards,
Marek Vasut
