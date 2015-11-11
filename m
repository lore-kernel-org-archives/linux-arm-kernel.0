From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 11 Nov 2015 09:26:38 +0100
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <alpine.DEB.2.11.1510202121590.8159@nanos>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
Message-ID: <20151111092638.587a53a4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Tue, 20 Oct 2015 21:23:29 +0200 (CEST), Thomas Gleixner wrote:

> > However, relying on IRQ_NOAUTOEN being cleared doesn't seem like the
> > right long term solution, which is why I implemented what I believe is
> > a (hopefully) better long term solution.
> 
> Agreed.
> 
> I'll go over the proposed solution tomorrow afternoon (I'm
> traveling/conferencing...)

Have you had the time to consider the proposed solution? For 4.3 we
implemented the quick work-around that consisted in clearing
IRQ_NOAUTOEN, but it's probably not a very good long-term solution.

Don't hesitate to let me know if you'd like to see some modifications
to the proposed approach, or if you have a totally different approach
in mind.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
