From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 20 Oct 2013 19:50:49 +0200
Subject: [PATCH v2 00/27] Armada 370/XP NAND support
In-Reply-To: <20131019162158.GA3044@localhost>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131019063535.GC20157@1wt.eu>
 <20131019142549.GO22434@titan.lakedaemon.net>
 <20131019162158.GA3044@localhost>
Message-ID: <20131020195049.7e683d0f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Sat, 19 Oct 2013 13:21:59 -0300, Ezequiel Garcia wrote:

> > > I strongly believe that all the information above is very valuable and
> > > that it's a shame to lose it in a cover message. It would definitely
> > > make sense to have this in a doc file.
> > 
> > Agreed.  Great work Ezequiel!  Let's capture this in Documentation/.
> > 
> 
> Wait a second!
> 
>   $ ls Documentation/mtd/ | wc -l
>   1
> 
> Isn't documenting deprecated? ...
> 
> Just kiddin'! I'll add this and the other cover to Documentation/
> so typos and english fixes are welcome!

I certainly agree this documentation should be kept, but I'm wondering
if keeping it as a comment inside the driver doesn't make more sense.
This document is really more about specific implementation details, and
the next person looking at the driver is not very likely to search such
details in Documentation/, in my opinion.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
