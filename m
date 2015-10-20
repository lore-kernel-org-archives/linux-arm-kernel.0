From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 20 Oct 2015 21:23:29 +0200 (CEST)
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <20151020160828.497fcc80@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1510202121590.8159@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Oct 2015, Thomas Petazzoni wrote:
> As discussed on IRC, another simpler (code line wise) solution is to
> simply clear the IRQ_NOAUTOEN flag in the irq-armada-370-xp, which
> brings us back to what set_irq_flags() was doing, without actually
> reverting Rob's patch.

I prefer that for 4.3.
 
> However, relying on IRQ_NOAUTOEN being cleared doesn't seem like the
> right long term solution, which is why I implemented what I believe is
> a (hopefully) better long term solution.

Agreed.

I'll go over the proposed solution tomorrow afternoon (I'm
traveling/conferencing...)

Thanks,

	tglx
