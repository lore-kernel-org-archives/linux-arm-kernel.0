From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 27 Aug 2014 14:37:07 -0400
Subject: [PATCH 0/7] ARM: OMAP4+: powerdomain fixes
In-Reply-To: <1408715373-25791-1-git-send-email-nm@ti.com>
References: <1408715373-25791-1-git-send-email-nm@ti.com>
Message-ID: <53FE2553.1020909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 August 2014 09:49 AM, Nishanth Menon wrote:
> Hi,
> 
> The following series are various fixes and improvements for
> powerdomain support in OMAP4+.
> 
> This is part 1/6 series which eventually enables framework for
> suspend-to-ram and cpuidle for OMAP5 and DRA7
> 
> Each of series is based on v3.17-rc1 and this specific series is available:
> weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/powerdomain-fixes
>
Series looks good to me. The achievable power state doesn't apeal much but with so many
variations of SOCs, descopes etc, it probably makes sense.

Once you update Kevin's BUG() comments, feel free to add my ack.

Regards,
Santosh
 
