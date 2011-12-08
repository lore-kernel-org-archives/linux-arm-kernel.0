From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 8 Dec 2011 20:21:27 +0800
Subject: [PATCH V2 1/2] ARM: mx51/53: correct misuse of _clk_max_enable
 and _clk_max_disable
In-Reply-To: <20111208095508.GW27267@pengutronix.de>
References: <1323307714-21290-1-git-send-email-richard.zhao@linaro.org>
 <1323307714-21290-2-git-send-email-richard.zhao@linaro.org>
 <20111208095508.GW27267@pengutronix.de>
Message-ID: <20111208122122.GB1837@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 10:55:08AM +0100, Sascha Hauer wrote:
> On Thu, Dec 08, 2011 at 09:28:33AM +0800, Richard Zhao wrote:
> > _clk_max_enable and _clk_max_disable should only be used by ahb_max_clk,
> > rather not unrelated clocks.
> 
> Since you based this onto arm-soc/for-net I assume applying it for
> next is ok for you?
It's up to you. Applying for-next probably avoid merge conflicts.

Thanks
Richard
> 
> Sascha
