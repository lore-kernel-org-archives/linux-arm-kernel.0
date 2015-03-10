From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 10 Mar 2015 13:02:09 -0700
Subject: [PATCH] ARM: at91: force CPU selection
In-Reply-To: <2216832.iXiqHye8YX@wuerfel>
References: <1425970798-14015-1-git-send-email-computersforpeace@gmail.com>
 <2216832.iXiqHye8YX@wuerfel>
Message-ID: <20150310200209.GE4124@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 10:02:15AM +0100, Arnd Bergmann wrote:
> I actually added a bunch of these in other places, but have stopped
> doing so because Russell didn't like them, and I tend to follow
> his argument now that it's actually pretty confusing.

I'm not a big fan of my patch, but it did at least solve the problem.
Thanks for the info, and I'm happy to drop my patch. At least I've fixed
my compile-test setups to avoid bad combinations, now.

To be clear, multiplatform support is in progress, but not merged yet,
right?

Brian
