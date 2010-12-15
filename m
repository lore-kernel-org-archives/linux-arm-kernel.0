From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 18:15:39 -0700 (MST)
Subject: [PATCH 05/12] OMAP4: PRCM: Add SCRM header file
In-Reply-To: <4D07D0A5.9040703@ti.com>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
	<20101214063447.21555.64470.stgit@twilight.localdomain>
	<4D07782E.5050000@ti.com>
	<alpine.DEB.2.00.1012141105570.15971@utopia.booyaka.com>
	<4D07D0A5.9040703@ti.com>
Message-ID: <alpine.DEB.2.00.1012141813180.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Beno?t

On Tue, 14 Dec 2010, Cousson, Benoit wrote:

> Well, I sent this series before you sent your prcm one, so at the time the
> dependency didn't exist ;-)

No worries, it was just meant to be a general suggestion, not a specific 
one to this case.

> > As far as the empty scrm44xx.h goes, I will probably go back and rebuild
> > that branch with your patch that creates SCRM from my patch set inserted
> > earlier, so I can drop the part of my patch that creates the empty file.

I went ahead and moved the SCRM patch earlier in the branch sets.  I did 
make one change in it - I'll reply to it with the update details.

The current integration tag that contains the revised patch is 
'integration-2.6.38-20101214-010' available from 
git://git.pwsan.com/linux-integration


- Paul
