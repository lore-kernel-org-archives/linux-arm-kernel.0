From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Dec 2010 19:48:36 -0800
Subject: [GIT] pull request: DMA hwmod changes
In-Reply-To: <20101221021152.GA18883@manju-desktop>
References: <20101219035948.GC15568@GLPP-machine> <4D0F33C9.40402@ti.com>
	<20101221021152.GA18883@manju-desktop>
Message-ID: <20101221034836.GE5829@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* G, Manjunath Kondaiah <manjugk@ti.com> [101220 18:11]:
> Hi Tony,
> Benoit comments are taken care and new pull request is generated as
> below. The omap4 hwmod database for dma is rearranged as per Benoit's
> convention + no idlest flag entry is removed + sysc_flags are barrowed
> from latest omap4 hwmod data base.

OK great, I've applied them now.
 
> The following changes since commit 205e4d6e8d892176d791b77a974efe7f561ca4c3:
> 
>   Merge branch 'for-next' (2010-12-17 19:32:47 -0800)

I ended up cherry picking them. For next time, note that you should not
do any git branches to pull against anything but mainline tags. Otherwise
tons of non-mainline history would get merged..

If you cannot base your branch on some recent mainline tag because of
conflicts, then you should use some branch that will stay around,
like what we have queued into omap-for-linus.

Cheers,

Tony
