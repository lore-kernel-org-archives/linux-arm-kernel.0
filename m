From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 14 Dec 2011 15:50:04 +0800
Subject: [PATCH v4 3/6] clk: introduce the common clock framework
In-Reply-To: <1323834838-2206-4-git-send-email-mturquette@linaro.org>
References: <1323834838-2206-1-git-send-email-mturquette@linaro.org>
 <1323834838-2206-4-git-send-email-mturquette@linaro.org>
Message-ID: <20111214074922.GM28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,
> + *
> + * @recalc_rate	Recalculate the rate of this clock, by quering hardware
> + * 		and/or the clock's parent. It is up to the caller to insure
> + * 		that the prepare_mutex is held across this call.  Returns the
> + * 		calculated rate.  Optional, but recommended - if this op is not
> + * 		set then clock rate will be initialized to 0.
I'm still concerned, if it's NULL, why don't just retrun parent's rate if it has? 
 
Thanks
Richard
