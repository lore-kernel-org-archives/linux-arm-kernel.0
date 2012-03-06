From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Mar 2012 11:51:07 -0500 (EST)
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <201203061412.00073.arnd@arndb.de>
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201202281945.39419.arnd@arndb.de>
 <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
 <201203061412.00073.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Mar 2012, Arnd Bergmann wrote:

> On Tuesday 06 March 2012, Nicolas Pitre wrote:
> > FYI, here's a snippet of a conversation I just had with Lennert on IRC 
> > today:
> > 
> > 13:05 < nico> do you still care about ixp2000?
> > 13:22 < lennert> not really, no
> > 13:58 < nico> do you think we could remove it from the kernel tree?
> > 14:01 < lennert> go for it, and remove ixp23xx too while you're at it
> 
> Ah, good to know that Lennert is actually still alive somewhere.
> 
> And removing ixp2xxx in 3.5 will certainly help us, too. 
> 
> Interestingly, that leaves ixp4xx as the only big-endian ARM platform.
> I believe that ixp4xx is still being actively used quite a bit, but does
> that include the big-endian ones? There is no immediate reason why we
> would want to drop support for big-endian, but if it's not used at all,
> that would be an interesting cleanup opportunity.

The NSLU2 is (was) a quite popular NAS device and it is used in big 
endian by default.

The BE support isn't getting in the way of anything, so there is no 
reason to remove it, even if it isn't being used much.


Nicolas
