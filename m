From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:56:28 -0700
Subject: [PATCH 03/12] ARM: unicore32: Remove depency on LATCH
In-Reply-To: <20110804134757.GA1019@plexity.net>
References: <cover.1312455035.git.dsaxena@linaro.org>
	<20110804134757.GA1019@plexity.net>
Message-ID: <20110804135628.GA1204@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Aug 04 2011, at 06:47, Deepak Saxena was caught saying:
> As part of work to remove the global CLOCK_TICK_RATE symbol,
> this patch defines a sub-arch local value for use by the
> at91 code.  Once all LATCH and CLOCK_TICK_RATE references
> are removed, we will remove all the definitions across
> sub-arches.

Obviously ignore this one, this should have been in another branch. :)

~Deepak

-- 
"People think all we need to fix our predicament is a free source of
energy, but I think we need to change out behaviour. More energy would
just deplete the Earth's lifeblood faster." - Janine Benyius
