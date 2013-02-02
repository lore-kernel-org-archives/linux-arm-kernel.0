From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 2 Feb 2013 13:50:25 +0530
Subject: [PATCHv3 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <1359740758-29703-4-git-send-email-dinguyen@altera.com>
References: <1359740758-29703-1-git-send-email-dinguyen@altera.com>
 <1359740758-29703-4-git-send-email-dinguyen@altera.com>
Message-ID: <510CCC49.6020002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013 11:15 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> mach-socfpga is another platform that needs to use
> v7_invalidate_l1 to bringup additional cores. There was a comment that
> the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

> ---
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
