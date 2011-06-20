From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 20 Jun 2011 15:09:36 +0530
Subject: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
In-Reply-To: <20110620092341.357.14183.stgit@kaulin>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin>
Message-ID: <4DFF1558.4020509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/20/2011 2:53 PM, Tony Lindgren wrote:
> This removes the support for setting the wake-up timer for debugging.
>
> Later on we can reserve gptimer1 for PM code only and have similar
> functionality.
>
> Signed-off-by: Tony Lindgren<tony@atomide.com>
> Reviewed-by: Kevin Hilman<khilman@ti.com>
> ---

Kevin cleaned up this with a better patch.
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg50015.html

May be we can use that patch instead of this.

Regards
Santosh
