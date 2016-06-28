From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Jun 2016 11:24:20 +0100
Subject: [PATCH v2 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <cover.1457539621.git.jglauber@cavium.com>
References: <cover.1457539621.git.jglauber@cavium.com>
Message-ID: <20160628102419.GA5425@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On Wed, Mar 09, 2016 at 05:21:02PM +0100, Jan Glauber wrote:
> This patch series provides access to various counters on the ThunderX SOC.
> 
> For details of the uncore implementation see patch #1.
> 
> Patches #2-5 add the various ThunderX specific PMUs.
> 
> As suggested I've put the files under drivers/perf/uncore. I would
> prefer this location over drivers/bus because not all of the uncore
> drivers are bus related.

What's the status of these patches? Were you planning to send a new
version?

Will
