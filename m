From: vince@kyllikki.org (Vincent Sanders)
Date: Wed, 4 Aug 2010 12:01:30 +0100
Subject: [PATCH] Remove ARM default configurations which duplicate
	omap3_defconfig
In-Reply-To: <20100804053533.GB6840@atomide.com>
References: <20100803201921.GA18698@kyllikki.org>
	<20100804053533.GB6840@atomide.com>
Message-ID: <20100804110130.GA30181@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 04, 2010 at 08:35:36AM +0300, Tony Lindgren wrote:
> * Vincent Sanders <vince@simtec.co.uk> [100803 23:23]:
> > These configurations are no longer useful as the systems they support
> > are covered by the generic omap3_defconfig
> 
> Since the defconfigs will stay around at least for a while
> in the compacted form..

The default configuration situation is simply insane there are over
170 of them for crying out loud. We *need* to reduce the number to
sane levels or Linus will simply rm the lot.

> 
> .. And until we have sorted out how to deal with which drivers
> need to be compiled in or as modules for each board, I'd
> rather keep these defconfigs around for now.
> 

> Can we just disable building these with some blacklist
> in Kautobuild?
> 

There is no such thing, the point was to reduce the number of configurations.

> > Signed-off-by:Vincent Sanders <vince@simtec.co.uk>
> > Acked-by:Tony Lindgren <tony@atomide.com>
> 
> So Not-yet-acked-by until some Kconfig issues are sorted out :)
> 

I obviously misinterpreted your ack in your previous mail. 

I give up, really, its completely pointless to carry on even trying to
make this situation better, noone else really cares so...  

I am on holiday for a few weeks so will not be moderating the lists or
running the autobuilder for that time. If on my return I feel like it
I may turn kautobuild back on but probably not.

-- 
So long and thanks for all the fish!
Vincent Sanders
http://www.kyllikki.org/
