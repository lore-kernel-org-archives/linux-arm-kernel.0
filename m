From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Jun 2012 13:49:45 +0200
Subject: [PATCH v7 08/14] USB: Chipidea: add ci13xxx device id management
In-Reply-To: <20120627054231.GA21750@b20223-02.ap.freescale.net>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <4FE83AA9.6030507@pengutronix.de>
 <20120627054231.GA21750@b20223-02.ap.freescale.net>
Message-ID: <201206271349.45641.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

> On Mon, Jun 25, 2012 at 12:17:13PM +0200, Marc Kleine-Budde wrote:
> > On 06/25/2012 12:03 PM, Richard Zhao wrote:
> > > Could you use my USB test branch?
> > 
> > Same result:
> > 
> > ci_hdrc ci_hdrc.0: remove, state 1
> > usb usb1: USB disconnect, device number 1
> > ci_hdrc ci_hdrc.0: USB bus 1 deregistered
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 0000006c pgd = c6ba4000
> > [0000006c] *pgd=46a68831, *pte=00000000, *ppte=00000000
> > Internal error: Oops: 17 [#1] PREEMPT ARM
> > Modules linked in: ci13xxx_imx(-) ci_hdrc imx_usbmisc
> > CPU: 0    Not tainted  (3.5.0-rc4-00058-g01710ef #85)

Dumb question -- you use the same base revision of kernel, right?

> 
> Thanks
> Richard
> 
> > Marc

Best regards,
Marek Vasut
