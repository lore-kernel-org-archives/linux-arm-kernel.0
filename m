From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 03:52:12 +0200
Subject: [PATCH v9 REBASE 0/9] add imx usb driver based on Greg next tree
In-Reply-To: <20120709170219.GA21319@kroah.com>
References: <1341673008-29808-1-git-send-email-richard.zhao@freescale.com>
 <20120709170219.GA21319@kroah.com>
Message-ID: <201207100352.13184.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Greg KH,

> On Sat, Jul 07, 2012 at 10:56:39PM +0800, Richard Zhao wrote:
> > The work is based on  ci13xxx rework done by Alexander Shishkin.
> > 
> > To let Greg pick up, I also added patches Alex queued that I depends on.
> 
> I've applied everything but patch number 6, which I've responded to
> with some questions about it.

That #6 emerged after discussion with Alan. It's unlikely on most hardware, but 
there are a few pieces where that case will happen.

> thanks,
> 
> greg k-h

Best regards,
Marek Vasut
