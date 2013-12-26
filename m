From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Dec 2013 17:49:20 +0100
Subject: [PATCH 2/2] ARM: mvebu: move Armada 370/XP specific definitions
 to armada-370-xp.h
In-Reply-To: <20131226161806.GC19323@lunn.ch>
References: <1388046026-332-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1388046026-332-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131226160048.GA19323@lunn.ch> <20131226170454.79529766@skate>
 <20131226161806.GC19323@lunn.ch>
Message-ID: <20131226174920.5d404189@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 26 Dec 2013 17:18:06 +0100, Andrew Lunn wrote:

> > As it is today, none of the contents of armada-370-xp.h are useful for
> > Armada 370. However, the "main" file is also named armada-370-xp.c and
> > handles both SoC, so it made sense to have a file named armada-370-xp.h
> > as well.
> 
> Hi Thomas
> 
> So thinking about dove, kirkwood, this new SoC, all living in mvebu,
> should we have a board-dt.c file which all SoCs share, and then one
> .c/.h pair of files per SoC? I'm saying this without looking at the
> actual content, so i've no idea is this is actually possible. I guess
> we need to do something like this sometime, but does it need to be
> now?

I think it's a bit hard to see now what will be the common parts. I
personally would worry too much about this though, as code can easily be
reorganized as needed as we see patterns emerge and gain a better
understanding of what's common and what's specific.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
