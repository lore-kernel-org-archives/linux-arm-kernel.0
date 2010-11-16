From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 16 Nov 2010 09:16:52 +0000
Subject: [PATCH 1/5] ARM: perf: consolidate common PMU behaviour
In-Reply-To: <1289842263-21241-2-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<1289842263-21241-2-git-send-email-will.deacon@arm.com>
Message-ID: <20101116091652.GD2764@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 05:30:59PM +0000, Will Deacon wrote:
> The functions for mapping PMU events (perf, cache and raw) are
> common between all PMU types and differ only in the data on which
> they operate.
> 
> This patch implements common definitions of these mapping functions
> and changes the arm_pmu struct to hold pointers to the data which
> they require. This is in anticipation of separating out the PMU-specific
> code into separate files.
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
Looks fine to me.

Acked-by: Jamie Iles <jamie@jamieiles.com>
