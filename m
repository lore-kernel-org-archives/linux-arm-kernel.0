From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 28 May 2015 11:04:27 +0200
Subject: [PATCH] clk: make several parent names const
In-Reply-To: <1432802751-6397-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1432802751-6397-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5566DA1B.8090205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/15 10:45, Uwe Kleine-K?nig wrote:
> Since commit 2893c379461a ("clk: make strings in parent name arrays
> const") the name of parent clocks can be const. So add more const in
> several clock drivers.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks for the patch,
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

-- 
Regards,
Sylwester
