From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 13 Nov 2015 15:11:16 -0500 (EST)
Subject: [PATCH 0/5] Fix regression introduced by set_irq_flags() removal
In-Reply-To: <20151111092638.587a53a4@free-electrons.com>
References: <1445347435-2333-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20151020140427.GE3953@io.lakedaemon.net>
 <20151020160828.497fcc80@free-electrons.com>
 <alpine.DEB.2.11.1510202121590.8159@nanos>
 <20151111092638.587a53a4@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1511131509180.3987@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wed, 11 Nov 2015, Thomas Petazzoni wrote:
> Have you had the time to consider the proposed solution? For 4.3 we
> implemented the quick work-around that consisted in clearing
> IRQ_NOAUTOEN, but it's probably not a very good long-term solution.
> 
> Don't hesitate to let me know if you'd like to see some modifications
> to the proposed approach, or if you have a totally different approach
> in mind.

I'm not sure if we really need all that muck if we can just rely on
that flag. I don't see the extra value, but you might have something
in mind which does not jump into my face right now.

Thanks,

	tglx
