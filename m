From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 13 Sep 2012 09:55:05 -0700
Subject: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
In-Reply-To: <20120913180457.1396637b@bob.linux.org.uk>
References: <20120913150133.GA16238@lizard>
 <20120913180457.1396637b@bob.linux.org.uk>
Message-ID: <20120913165505.GA6517@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 06:04:57PM +0100, Alan Cox wrote:
> On Thu, 13 Sep 2012 08:01:33 -0700
> Anton Vorontsov <anton.vorontsov@linaro.org> wrote:
> 
> > Hi all,
> > 
> > Here comes the lucky v7:
> > 
> > - Per Alan Cox's suggestion added hangup method and removed a small
> >   leftover;
> > - Per Colin Cross' suggestion moved IRQ quiescing logic into
> >   poll_get_char routine. IIUC, Alan is less unhappy about it.  As a
> >   result, clear_irq() callback dropped.
> 
> Ok that has my ack. Some of it is not pretty but debugger hooks that
> have to run behind the OS while debugging it never are.
> 
> Acked-by: Alan Cox <alan@linux.intel.com>

Great! Much thanks for reviews, Alan.
