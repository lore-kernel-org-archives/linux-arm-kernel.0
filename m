From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 15 Nov 2010 19:02:28 +0000
Subject: [PATCH 2/5] ARM: perf: avoid exposing internal stop function for
	v6 PMU
In-Reply-To: <1289842263-21241-3-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<1289842263-21241-3-git-send-email-will.deacon@arm.com>
Message-ID: <20101115190228.GB2764@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 05:31:00PM +0000, Will Deacon wrote:
> Unlike other pmu functions, armv6pmu_pmu_stop is not declared static.
> This patch adds the missing keyword.
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
Yep, good spot. Btw, my employer has changed to Exchange for our email and it 
has a habit of munging patches on the way in so I'll have to switch to my 
personal email now!

Acked-by: Jamie Iles <jamie@jamieiles.com>
