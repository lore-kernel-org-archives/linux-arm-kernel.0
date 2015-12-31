From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 30 Dec 2015 18:58:31 -0800
Subject: [GIT PULL] BCM2835/6 changes for 4.5 (I hope)
In-Reply-To: <1451365282-10505-1-git-send-email-eric@anholt.net>
References: <1451365282-10505-1-git-send-email-eric@anholt.net>
Message-ID: <568499D7.8030400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/12/2015 21:01, Eric Anholt a ?crit :
> Apparently this is really late in the process (sorry!  I still haven't
> figured out the timelines.), but I'm hoping we could merge these
> changes for 4.5.  This includes the Raspberry Pi 2 port, with just two
> minor fixes from the last submission.
> 
> The reason I've been pushing hard to get pi2 in is:
> 
> 1) It's a lot of conflict resolution every version since it requires
> splitting the 2835 DT file.
> 
> 2) People are generally using pi2 these days, so it means people are
> more likely to upstream 2835 driver code if we have an upstream port
> they can run.
> 
> Testing status: kbuild test robot builds passed.  Boot tested each
> branch head on pi1.  Boot tested the merge of all 4 branches on pi1.
> Boot tested the merge of all 4 branches on pi2, with and without the
> irqchip fixes.

Considering that we are fairly late for v4.5, I would prefer if Arnd,
Olof or Kevin could take these directly into their respective branches,
if this is really really too late, then I will queue these changes, and
the next ones you have for v4.6.

Thanks and happy holidays!
-- 
Florian
