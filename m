From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 17 Aug 2014 20:04:45 -0400 (EDT)
Subject: [PATCH v4] irqchip: gic: Allow gic_arch_extn hooks to call into
 scheduler
In-Reply-To: <20140817190434.GJ12769@titan.lakedaemon.net>
References: <1407938238-21413-1-git-send-email-sboyd@codeaurora.org>
 <20140817173236.GG12769@titan.lakedaemon.net>
 <20140817185522.GX30401@n2100.arm.linux.org.uk>
 <20140817190434.GJ12769@titan.lakedaemon.net>
Message-ID: <alpine.LFD.2.11.1408172000460.29347@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 Aug 2014, Jason Cooper wrote:

> Russell,
> 
> On Sun, Aug 17, 2014 at 07:55:23PM +0100, Russell King - ARM Linux wrote:
> > On Sun, Aug 17, 2014 at 01:32:36PM -0400, Jason Cooper wrote:
> > > Applied to irqchip/urgent with Nico's Ack.
> > 
> > Interesting, so I'm discussing this patch, and it gets applied anyway...
> > yes, that's great.
> 
> Quoting Nico:
> 
> "Of course it would be good to clarify things wrt Russell's remark
> independently from this patch."
> 
> I took 'independently' to mean "This patch is ok, *and* we need to
> address Russell's concerns in a follow-up patch."
> 
> Nico's Reviewed-by with that comment was sent August 13th.  The most
> recent activity on this thread was also August 13th.  After four days, I
> reasoned there were no objections to his comment.

Well... I mentioned this patch is a nice cleanup independently of the 
reason why it was created in the first place.  Maybe that shouldn't be 
sorted as "urgent" in that case, especially when the code having problem 
with the current state of things is living out of mainline.


Nicolas
