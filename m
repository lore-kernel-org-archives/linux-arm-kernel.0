From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Dec 2016 09:12:36 +0100
Subject: [PATCH] clk: bcm: Fix 'maybe-uninitialized' warning in
 bcm2835_clock_choose_div_and_prate()
In-Reply-To: <1481529653-28133-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1481529653-28133-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <3107859.uaKLk6DMRd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 12, 2016 9:00:53 AM CET Boris Brezillon wrote:
> best_rate is reported as potentially uninitialized by gcc.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: 155e8b3b0ee3 ("clk: bcm: Support rate change propagation on bcm2835 clocks")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

I wonder why I didn't get that. Which compiler version did you use?

	Arnd
