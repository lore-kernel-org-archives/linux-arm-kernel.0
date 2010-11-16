From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 16 Nov 2010 09:18:31 +0000
Subject: [PATCH 3/5] ARM: perf: add _init() functions to PMUs
In-Reply-To: <1289842263-21241-4-git-send-email-will.deacon@arm.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<1289842263-21241-4-git-send-email-will.deacon@arm.com>
Message-ID: <20101116091831.GE2764@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 15, 2010 at 05:31:01PM +0000, Will Deacon wrote:
> In preparation for separating the PMU-specific code, this patch adds
> self-contained init functions to each PMU, therefore removing any
> PMU-specific knowledge from the PMU-agnostic init_hw_perf_events
> function.
> 
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
Yep, fine again!

Acked-by: Jamie Iles <jamie@jamieiles.com>
