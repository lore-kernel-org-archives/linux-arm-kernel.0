From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 28 May 2015 12:35:12 +0200
Subject: [PATCH] clk: make several parent names const
In-Reply-To: <1432802751-6397-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1432802751-6397-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <4095482.AGzSOmiiYQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 28. Mai 2015, 10:45:51 schrieb Uwe Kleine-K?nig:
> Since commit 2893c379461a ("clk: make strings in parent name arrays
> const") the name of parent clocks can be const. So add more const in
> several clock drivers.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>


Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
> Hello,
> 
> commit 2893c379461a isn't in Linus Torvald's tree yet, so the commit
> message needs adaption if clk-next is rewritten.
> 
> Should I split this patch per subdir?

I don't have any Rockchip-related clock changes for 4.2, so for me it's not 
important if you split it or keep it together.


Thanks
Heiko
