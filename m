From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 22 Sep 2012 10:20:41 +0200
Subject: [GIT PULL V3 1/5] ARM: Kirkwood: address decoding change for v3.7
In-Reply-To: <20120922052904.GC32245@quad.lixom.net>
References: <20120829001129.GO19437@titan.lakedaemon.net>
 <20120921194141.GV5469@titan.lakedaemon.net>
 <20120922052904.GC32245@quad.lixom.net>
Message-ID: <20120922102041.5ef27c5b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Olof Johansson,

On Fri, 21 Sep 2012 22:29:04 -0700, Olof Johansson wrote:

> This branch has pretty massive merge conflicts with cleanup/io-pci
> and other branches, in particular due to the large number of
> conflicting cleanup patches.
> 
> It'd be better to focus on just the address decoding pieces in this
> branch, and move the cleanups to a separate branch. Given the state
> of affairs w.r.t. conflicts for the cleanups, saving those for 3.8
> might be a better idea.
> 
> I mentioned in one of the other comments to a patch in this series
> that I was going to pull this in as staging/* and get linux-next
> coverage, but these conflicts are more than what I want to deal with
> now -- so I'll hold off pulling these in after all.

This is really surprising. Those cleanups were explicitly requested by
Arnd Bergmann during the review process of my address decoding patch
set. The earlier version of this patch set was only doing address
decoding changes, not the IOMEM() cleanup. And Arnd requested the
IOMEM() cleanup to be done as a pre-requisite to the address decoding
changes. I've therefore spent two days last week doing these cleanups
and retesting the address decoding changes, and now you're telling us
exactly the opposite of what Arnd said two weeks ago?

I'm sorry but that doesn't really fair here.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
