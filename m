From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 14 Dec 2010 11:13:22 -0700 (MST)
Subject: [PATCH 05/12] OMAP4: PRCM: Add SCRM header file
In-Reply-To: <4D07782E.5050000@ti.com>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
	<20101214063447.21555.64470.stgit@twilight.localdomain>
	<4D07782E.5050000@ti.com>
Message-ID: <alpine.DEB.2.00.1012141105570.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Dec 2010, Cousson, Benoit wrote:

> This patch will conflict with your power prcm series, because you are creating
> an empty scrm44xx.h in it.
> 
> So I did rebased this series on top on your prcm to fix that.
> 
> Don't you want to use the already rebased version instead?

I would rather have patches and branches based on mainline commits where 
possible.  If a series has some explicit dependency on a non-mainline 
patch or branch then I'd like to know about it in the messages if 
possible.

As far as the empty scrm44xx.h goes, I will probably go back and rebuild 
that branch with your patch that creates SCRM from my patch set inserted 
earlier, so I can drop the part of my patch that creates the empty file.


- Paul
