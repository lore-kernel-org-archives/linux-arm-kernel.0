From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 17 Feb 2014 11:23:36 +0100
Subject: [PATCH v3 01/13] ARM: mvebu: rename armada-370-xp.c to
 armada-mvebu.c
In-Reply-To: <20140217024951.GI7862@titan.lakedaemon.net>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392289475-8902-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <2036226.egxWL7qC66@wuerfel> <20140213125526.3af08c54@skate>
 <20140213130745.GU27395@titan.lakedaemon.net>
 <20140213141355.00e8f2fd@skate> <52FCC771.5090009@gmail.com>
 <20140213142924.4520ccc9@skate>
 <20140217024951.GI7862@titan.lakedaemon.net>
Message-ID: <20140217112336.5ecbb54f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Sun, 16 Feb 2014 21:49:51 -0500, Jason Cooper wrote:

> > Yes, I agree. I'm fully convinced by the idea of merging the v7 support
> > together, but we need to proceed step by step to avoid having horrible
> > merge issues during the 3.15 cycle.
> 
> Yeah, I don't see how anything can go wrong at all.  :)
> 
> btw - I'll hold off on pulling this for a new revision.  Looks like the
> only change left in the file name.

I'll be posting a v4 today. It will contain this rename, and also a few
more DT nodes for Armada 375 that enable NAND support, since we have
sent the corediv clock patches, which were necessary for NAND support
to work.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
