From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Dec 2010 22:48:14 +0000
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <AANLkTimarRAf-_ykQNLgzXd3TtUHhSw+gZ6cZ5pW=Y-9@mail.gmail.com>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<AANLkTimarRAf-_ykQNLgzXd3TtUHhSw+gZ6cZ5pW=Y-9@mail.gmail.com>
Message-ID: <20101220224814.GJ28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 20, 2010 at 11:32:21AM +0800, Eric Miao wrote:
> On Fri, Dec 17, 2010 at 7:32 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Here is the entire set of clocksource and sched_clock patches which
> > have been previously posted. ?There's a couple of small tweaks in a
> > few of the patches (such as adding notrace to OMAP clocksource read
> > functions), and this also shows the proper ordering of these patches.
> >
> > Still looking for acks or tested-by's for these patches.
> >
> 
> Hi Russell,
> 
> Sorry for late feedback. Tested the branch 'clksrc' on Littleton/PXA3xx,
> seems to be good.
> 
> Tested-by: Eric Miao <eric.y.miao@gmail.com>

Ok, I'll add that to the PXA and generic patches, thanks.
