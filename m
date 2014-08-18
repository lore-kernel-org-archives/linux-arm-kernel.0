From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Aug 2014 21:32:24 -0400
Subject: [PATCH v4] irqchip: gic: Allow gic_arch_extn hooks to call
 into scheduler
In-Reply-To: <20140817214123.GY30401@n2100.arm.linux.org.uk>
References: <1407938238-21413-1-git-send-email-sboyd@codeaurora.org>
 <20140817173236.GG12769@titan.lakedaemon.net>
 <20140817185522.GX30401@n2100.arm.linux.org.uk>
 <20140817190434.GJ12769@titan.lakedaemon.net>
 <20140817214123.GY30401@n2100.arm.linux.org.uk>
Message-ID: <20140818013224.GM12769@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 10:41:23PM +0100, Russell King - ARM Linux wrote:
> On Sun, Aug 17, 2014 at 03:04:34PM -0400, Jason Cooper wrote:
> > Quoting Nico:
> > 
> > "Of course it would be good to clarify things wrt Russell's remark
> > independently from this patch."
> > 
> > I took 'independently' to mean "This patch is ok, *and* we need to
> > address Russell's concerns in a follow-up patch."
> > 
> > Nico's Reviewed-by with that comment was sent August 13th.  The most
> > recent activity on this thread was also August 13th.  After four days, I
> > reasoned there were no objections to his comment.
> 
> Right, during the merge window, and during merge windows, I tend to
> ignore almost all email now because people don't stop developing, and
> they don't take any notice where the mainline cycle is.  In fact, I go
> off and do non-kernel work during a merge window and only briefly scan
> for bug fixes.

Ok, now dropped.

thx,

Jason.
