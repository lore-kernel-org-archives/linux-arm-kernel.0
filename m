From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 30 Apr 2014 23:07:39 -0700
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency for
 M25P80)
In-Reply-To: <536000BA.4000101@wwwdotorg.org>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
 <535A8FC9.8040707@wwwdotorg.org>
 <20140429190603.GB9418@norris-Latitude-E6410>
 <536000BA.4000101@wwwdotorg.org>
Message-ID: <20140501060739.GH2497@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 01:42:50PM -0600, Stephen Warren wrote:
> I guess you could also just see if arm-soc (arm at kernel.org) will take
> this patch, and deal with any merge conflicts that arise when they merge
> all the sub-arch defconfig changes. I CC'd them to find out if they
> think that's a better idea.

I'm preparing a split patch series and should send v2 shortly. A few of
the unaccounted platforms + the multi-platform are lumped together for
direct inclusion in arm-soc (?).

What is this arm at kernel.org you speak of? My Google-fu doesn't turn up a
separate arm-soc email / mailing list, and it's not in MAINTAINERS.

Brian
