From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jul 2011 08:43:21 +0100
Subject: Git pull request: boot_params to atag_offset conversion
In-Reply-To: <alpine.LFD.2.00.1107190042280.21187@xanadu.home>
References: <alpine.LFD.2.00.1107190042280.21187@xanadu.home>
Message-ID: <20110719074321.GA26574@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 12:55:46AM -0400, Nicolas Pitre wrote:
> Russell, could you please pull:
> 
> 	git://git.linaro.org/people/nico/linux atag_offset
> 
> This contains the previously posted patches, plus the collected 
> Acked-by/Tested-by tags so far.  Since the discussion has died down, I 
> don't expect further changes.
> 
> Alternatively, this can go via the linux-arm-soc tree if you prefer 
> that.

Nope, I don't want it to go in this time around - the amount of patches
you posted last week was _far_ too much for what was billed as the last
week before the merge window, and by doing so you significantly
contributed to my stress levels.

I've not been following the discussion on these patches, and don't plan
to until after the merge window has closed.  Ditto for your other patches.

The last week before a merge window is supposed to be for final testing,
publishing "what's queued" stuff etc.  I wonder why I don't do that -
could it be because I'm always working right up to the next merge window
putting stuff in my git tree so I don't have any time to stablize it?

Before you get the idea that I'm being unfair, I too have a few series of
patches which I've not published, and I'm not pushing this merge window.
There's also patch series which I have posted, but haven't had a chance
to update for comments back, and so too aren't going to be going in this
time around.

Please, spread out posting of patches over the cycle.  Don't post 100+
patches across several patch series in just one day, and then expect
them to get merged within a week.
