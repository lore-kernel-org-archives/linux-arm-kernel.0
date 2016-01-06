From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 6 Jan 2016 11:12:41 +0100 (CET)
Subject: [PATCH] dmaengine: xgene-dma: Fix double IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
In-Reply-To: <CAOHikRALt92uf598bH2hWq-QKOVRxd+OEjZ2pRkRj5-F8ApD5w@mail.gmail.com>
References: <1450875495-2229-1-git-send-email-rsahu@apm.com>
 <20160106091323.GP2940@localhost>
 <CAFd313xhh_4OFP6W2yuApM8ppYMX20DUCCQHJ9YEtCMbzr6Hgg@mail.gmail.com>
 <20160106093121.GB11778@localhost> <alpine.DEB.2.11.1601061103000.3689@nanos>
 <CAOHikRALt92uf598bH2hWq-QKOVRxd+OEjZ2pRkRj5-F8ApD5w@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1601061111470.3689@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jan 2016, Suman Tripathi wrote:
> On Wed, Jan 6, 2016 at 3:35 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Why would I? Those helpers are core internal and not usable in random
> > drivers.
> >
> 
> i think the problem is the name of the function. It should be something
> 
> irq_check_settings_disable_unlazy

And why is that relevant to a driver? Again, those helpers are core internal
and well understood.

Thanks,

	tglx
