From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Feb 2014 18:21:57 -0500
Subject: [PATCHv2 2/2] arm: Get rid of meminfo
In-Reply-To: <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
References: <1391558551-31395-1-git-send-email-lauraa@codeaurora.org>
 <1391558551-31395-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <52F2C795.80604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 February 2014 07:02 PM, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
