From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Apr 2011 18:24:08 -0700
Subject: [PATCH] ARM: S3C64XX: Initial support for Wolfson/Simtec
	Cragganmore/Banff
In-Reply-To: <01bd01cbfa2e$1afae140$50f0a3c0$%kim@samsung.com>
References: <1302533295-27917-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<01bd01cbfa2e$1afae140$50f0a3c0$%kim@samsung.com>
Message-ID: <20110414012406.GA3789@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 07:56:22AM +0900, Kukjin Kim wrote:

> But I'm not sure this can be sent to upstream during the next merge window.
> Because of Linus' complaint, Russell does not want to add new stuff now,
> maybe you know. Basically my tree was sent to upstream via RMK when merge
> window.

Hrm, right.  I had thought that the restriction there applied to the
trees that Russell manages directly himself (the core ARM code) rather
than those subtrees which he pulls in for the subarchitectures.

> Hmm...for now I will make some branch for new stuff like this and keep it
> until everyone is happy. Of course, if any consolidation work in Linux ARM
> world, I will update.

> Or...if any good idea, please let me know :)

A separate tree, ideally merged into -next would be good (though of
course that's not really the -next rules...) if we are going to stop
doing any updates to machines.

I guess the other question is how is the device tree work for the
Samsung CPUs going?  Grant mentioned that you guys were actively working
on this but I've not found any patches yet (and of course everything
there is blocked on the core ARM device tree work).
