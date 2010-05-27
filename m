From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 27 May 2010 15:01:01 +0530
Subject: [PATCH] ARM:VFPv3:enable {d16-d31} access
In-Reply-To: <20100527092933.GB28112@n2100.arm.linux.org.uk>
References: <tarun.kanti@ti.com>
	<1274818736-26597-1-git-send-email-tarun.kanti@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
	<20100525185741.GB16204@n2100.arm.linux.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322FA8E37@dbde02.ent.ti.com>
	<20100526201017.GE6232@n2100.arm.linux.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB03230B1B3E@dbde02.ent.ti.com>
	<20100527092933.GB28112@n2100.arm.linux.org.uk>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03230B1D5B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Thursday, May 27, 2010 3:00 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM:VFPv3:enable {d16-d31} access
> 
> On Thu, May 27, 2010 at 10:07:40AM +0530, DebBarma, Tarun Kanti wrote:
> > > Note the different registers.  Change "r1, r2" to "r0, r1" and it
> > > should work.
> >
> > Yes, that's right. I figured that out yesterday and confirmed the test
> > results. Thanks!
> 
> I've now committed a fix to change those registers.  Are you ok with
> being credited with a Reported-by tag?

That's fine!
