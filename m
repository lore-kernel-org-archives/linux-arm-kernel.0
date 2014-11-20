From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 13:41:29 +0100
Subject: [GIT PULL] at91: dt for 3.19 #2
In-Reply-To: <1416415953-31966-1-git-send-email-nicolas.ferre@atmel.com>
References: <1416415953-31966-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <201411201341.30112.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014, Nicolas Ferre wrote:
> Another DT pull-request for 3.19. For this one, I had to pull one Vinod's topic
> branch to be able to include the XDMA DT properties. This branch is stable and
> based on 3.18-rc3 (Cf. http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304041.html).
> Note that my previous DT pull-request for 3.19 was based on 3.18-rc2.
> So, this is what I did:
> - took a v3.18-rc3 tag
> - merged the at91-3.19-dt branch that you already have in at91/dt (you'd taken the at91-dt tag)
> - merged the topic/at_xdmac from Vinod
> - stacked the new material described above on top of this.
> Tell me if it's okay for you or if I have to arrange things differently.
> 
> The content itself is pretty straightforward.
> 

I've pulled it into a new next/dt2 branch, so we don't have to coordinate the merging
with Vinod. If he sends the slave-dma tree first, this will be part of the normal
next/dt submission to Linus, otherwise it will come a few days later.

Thanks,

	Arnd
