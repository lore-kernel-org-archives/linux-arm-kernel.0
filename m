From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 29 Apr 2011 16:44:33 +0530
Subject: [PATCH 1/5] OMAP3 cpuidle: remove useless SDP specific timings
In-Reply-To: <1304069186-3086-2-git-send-email-j-pihet@ti.com>
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
	<1304069186-3086-2-git-send-email-j-pihet@ti.com>
Message-ID: <4DBA9D99.4070908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/29/2011 2:56 PM, jean.pihet at newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> The cpuidle states settings can be overriden by some board-
> specific settings, by calling omap3_pm_init_cpuidle.
> Remove the 3430SDP specific states settings registration
> since the figures are identical to the default ones (in cpuidle34xx.c).
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/mach-omap2/board-3430sdp.c |   19 -------------------
>   1 files changed, 0 insertions(+), 19 deletions(-)
>
Looks like the example table to show the API usage never got
updated with board specific timings :)

-19 lines more :)

Regards
Santosh
