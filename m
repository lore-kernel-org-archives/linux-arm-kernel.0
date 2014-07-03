From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 2 Jul 2014 17:26:41 -0700
Subject: [PATCH] mtd: s3c2410: Move to
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1404155536-3032-1-git-send-email-anarsoul@gmail.com>
References: <1404155536-3032-1-git-send-email-anarsoul@gmail.com>
Message-ID: <20140703002641.GP3599@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 10:12:16PM +0300, Vasily Khoruzhick wrote:
> Use clk_prepare_enable/clk_disable_unprepare to make the driver
> work properly with common clock framework.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Pushed to l2-mtd.git. Thanks!

Brian
