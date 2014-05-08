From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 May 2014 10:45:24 -0400
Subject: [PATCH 1/2] gpio: omap: prepare and unprepare the debounce clock
In-Reply-To: <1398233465-8845-2-git-send-email-rnayak@ti.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com>
 <1398233465-8845-2-git-send-email-rnayak@ti.com>
Message-ID: <536B9884.6030809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 April 2014 02:11 AM, Rajendra Nayak wrote:
> Replace the clk_enable()s with a clk_prepare_enable() and
> the clk_disables()s with a clk_disable_unprepare()
> 
> This never showed issues due to the OMAP platform code (hwmod)
> leaving these clocks in clk_prepare()ed state by default.
> 
> Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
$subject patch looks fine but I don't see patch 2/2 assuming this
is series of two patches.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
