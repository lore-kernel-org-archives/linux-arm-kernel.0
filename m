From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 13:23:56 +0000
Subject: [PATCH] ARM: ixp4xx: move fixed mapping of internal devices into
 vmalloc region
In-Reply-To: <m3oblic6x0.fsf@intrepid.localdomain>
References: <1346996400-5824-1-git-send-email-gerg@snapgear.com>
 <201209071223.30275.arnd@arndb.de> <m3oblic6x0.fsf@intrepid.localdomain>
Message-ID: <201209071323.56574.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Krzysztof Halasa wrote:
> >>   BUG: mapping for 0xc8000000 at 0xffbeb000 out of vmalloc space
> >>   BUG: mapping for 0xc4000000 at 0xffbfe000 out of vmalloc space
> >>   BUG: mapping for 0xc0000000 at 0xffbff000 out of vmalloc space
> 
> > Imre, Krzysztof: do you prefer to take this patch into a branch of yours
> > and send a pull request, or should we just apply it directly into arm-soc.
> > In the former case, can you provide an Ack?
> 
> My intention is to push the following instead:
> 
> http://git.kernel.org/?p=linux/kernel/git/chris/linux.git;a=commitdiff;h=f62736b567ff532fb772afea76fccdbcd92ab473;hp=23e3b6cf1c37ef0615d90681d3705a8821305b5f
> 

Ok, fine with me. I noticed however that this is missing
a changelog. Maybe you can take the text that Greg sent.

I also wonder if this patch needs to be applied to earlier
versions as well. Is linux-3.6 still working?

	Arnd
