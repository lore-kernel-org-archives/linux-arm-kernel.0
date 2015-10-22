From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 22 Oct 2015 10:01:40 +0200 (CEST)
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <alpine.DEB.2.11.1510202123330.8159@nanos>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <20151020141736.GX32532@n2100.arm.linux.org.uk>
 <alpine.DEB.2.11.1510202123330.8159@nanos>
Message-ID: <alpine.DEB.2.11.1510221000260.4012@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Oct 2015, Thomas Gleixner wrote:
> On Tue, 20 Oct 2015, Russell King - ARM Linux wrote:
> > I think Rob's patches need another review in light of this, to determine
> > how much breakage there is here, and a decision how to proceed made on
> > that basis.
> 
> I'll go over them tomorrow again and decide then what to do.

I went over them once more and the only affected wreck I found is the
armada one.

Thanks,

	tglx
