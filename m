From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 24 Jan 2015 18:20:00 +0100
Subject: [PATCH v3 0/5] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <alpine.DEB.2.11.1501241735530.5526@nanos>
References: <1422032971-14139-1-git-send-email-boris.brezillon@free-electrons.com>
 <alpine.DEB.2.11.1501241735530.5526@nanos>
Message-ID: <20150124182000.59a4a96b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Sat, 24 Jan 2015 17:37:48 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 23 Jan 2015, Boris Brezillon wrote:
> >  - change the compatible string to clearly show that this chip is purely
> >    virtual
> 
> So we probably want to do : s/dumb/virt/ for both DT and code to make
> it clear from the names as well.

I thought the dumb word was denoting the simplicity (stupidity ?) of
the irq demultiplexer, but indeed, I don't see how a virtual irq demuxer
could have enough information to do a better job (if there's an
interrupt cause register, then it's not a virtual/software demuxer
anymore).
So replacing dumb by virt or virtual makes sense here.


Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
