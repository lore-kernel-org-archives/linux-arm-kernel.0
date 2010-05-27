From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 May 2010 10:29:33 +0100
Subject: [PATCH] ARM:VFPv3:enable {d16-d31} access
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03230B1B3E@dbde02.ent.ti.com>
References: <tarun.kanti@ti.com>
	<1274818736-26597-1-git-send-email-tarun.kanti@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322FA884E@dbde02.ent.ti.com>
	<20100525185741.GB16204@n2100.arm.linux.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB0322FA8E37@dbde02.ent.ti.com>
	<20100526201017.GE6232@n2100.arm.linux.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB03230B1B3E@dbde02.ent.ti.com>
Message-ID: <20100527092933.GB28112@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 10:07:40AM +0530, DebBarma, Tarun Kanti wrote:
> > Note the different registers.  Change "r1, r2" to "r0, r1" and it
> > should work.
> 
> Yes, that's right. I figured that out yesterday and confirmed the test
> results. Thanks!

I've now committed a fix to change those registers.  Are you ok with
being credited with a Reported-by tag?
