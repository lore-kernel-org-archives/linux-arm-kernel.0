From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2011 14:56:35 +0000
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
In-Reply-To: <4EC6566C.70202@ti.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <4EC6566C.70202@ti.com>
Message-ID: <20111118145635.GB17991@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Fri, Nov 18, 2011 at 12:58:20PM +0000, Cousson, Benoit wrote:
> Hi Ming Lei,
> 
> Sorry, for the delay, it took me some time to gather the exhaustive data for that block. 

Thanks for looking at this! I don't think we'd have managed to get all of
the magic numbers in the right place ourselves :)

Ming Lei - can you take this into your patch series please?

Then we'll have:

	- The two perf patches in my tree
	- The hwmod fix in Tony's tree (pending pull)
	- Your patches plus this one for hooking everything together

The sooner we can push these into -next, the better.

Cheers,

Will
