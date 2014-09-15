From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 15 Sep 2014 21:49:07 +0200
Subject: [PATCH 0/5] irqchip: atmel-aic: add RTT irq fixup
In-Reply-To: <20140914054648.GJ21986@titan.lakedaemon.net>
References: <1409735271-15353-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140914054648.GJ21986@titan.lakedaemon.net>
Message-ID: <20140915214907.3ec49158@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, 14 Sep 2014 01:46:48 -0400
Jason Cooper <jason@lakedaemon.net> wrote:

> On Wed, Sep 03, 2014 at 11:07:46AM +0200, Boris BREZILLON wrote:
> > The series depends on the acceptation of the RTT DT bindings proposed here
> > [1].
> > 
> > Best Regards,
> > 
> > Boris
> > 
> > [1]https://lkml.org/lkml/2014/9/3/145
> 
> Hmm, the bindings, unfortunately, still seem to be in flux.  Any update?

Actually, all at91 developers seemed to agree on this binding [2], and
these changes do not impact the current series.

Anyway, I think it's safer to wait for an official approval before
taking this series into irqchip/next.

Best Regards,

Boris

[2]https://lkml.org/lkml/2014/9/11/513

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
?
