From: matt.porter@linaro.org (Matt Porter)
Date: Thu, 6 Mar 2014 03:55:43 -0500
Subject: [PATCH 0/4] ARM: bcm281xx: Consolidate code
In-Reply-To: <1393366666-28625-1-git-send-email-markus.mayer@linaro.org>
References: <1393366666-28625-1-git-send-email-markus.mayer@linaro.org>
Message-ID: <20140306085543.GE25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 02:17:42PM -0800, Markus Mayer wrote:
> This series contains some code consolidation for the Broadcom BCM281xx
> family of SoCs.
> 
> - Move kona_l2_cache_init() so other platforms can reuse it
> - Consolidate reboot code and move it to the board specific file
> - Sort header files in board file alphabetically
> - Rename the board_init() function to be board specific
> 
> Markus Mayer (4):
>   ARM: bcm281xx: Move kona_l2_cache_init() so it can be shared
>   ARM: bcm281xx: Consolidate reboot code
>   ARM: bcm281xx: Re-order hearder files
>   ARM: bcm281xx: Rename board_init() function

Applied to mach-bcm for-3.15/cleanup

-Matt
