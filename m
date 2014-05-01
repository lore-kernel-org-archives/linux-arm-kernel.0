From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 30 Apr 2014 23:08:38 -0700
Subject: [PATCH 1/5] ARM: defconfigs: add MTD_SPI_NOR (new dependency for
 M25P80)
In-Reply-To: <20140430114548.GQ28159@titan.lakedaemon.net>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <1397719309-2022-2-git-send-email-computersforpeace@gmail.com>
 <535A8FC9.8040707@wwwdotorg.org>
 <20140429190603.GB9418@norris-Latitude-E6410>
 <20140430114548.GQ28159@titan.lakedaemon.net>
Message-ID: <20140501060838.GI2497@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 07:45:48AM -0400, Jason Cooper wrote:
> On Tue, Apr 29, 2014 at 12:06:03PM -0700, Brian Norris wrote:
> > I'll also rebase on linux-next. I think there may be a few conflicts.
> 
> I can't speak for the other sub-archs, but I typically prefer that
> patches be based on an -rc tag, -rc1 if possible.

OK, this was already based on -rc1. I'll leave it as-is, and maintainers
can easily work out the conflicts.

Thanks,
Brian
