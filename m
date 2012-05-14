From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 May 2012 17:00:28 +0100
Subject: [PATCH v4 2/2] ARM: vfp: clear fpscr length and stride bits on
 entry to sig handler
In-Reply-To: <20120514145931.GF11088@mudshark.cambridge.arm.com>
References: <1330009632-1235-1-git-send-email-will.deacon@arm.com>
 <1330009632-1235-2-git-send-email-will.deacon@arm.com>
 <1337006035.16954.21.camel@linaro1.home>
 <20120514145931.GF11088@mudshark.cambridge.arm.com>
Message-ID: <20120514160028.GG11088@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 03:59:31PM +0100, Will Deacon wrote:
> On Mon, May 14, 2012 at 03:33:55PM +0100, Jon Medhurst (Tixy) wrote:
> > I've bisected a screen corruption problem on vexpress down to this
> > commit, I've commented at the end of the patch at to what I see the
> > problem being...
> 
> Interesting and thanks for the heads up. I've been running with this patch
> applied for ages and haven't seen any problems myself but I've also been
> running headless. What's the best way to reproduce the problem on vexpress?
> I can connect a display if required.

Right, I've managed to trigger it on my board with lxdm, so I'll dig further
and let you know. The patch I posted doesn't help, so don't waste time
applying it.

Cheers,

Will
