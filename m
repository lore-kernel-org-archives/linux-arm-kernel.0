From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Dec 2013 18:51:29 +0100
Subject: [PATCH Resend 1/1] clk: exynos5250: Add CLK_SET_RATE_PARENT flag
 to mout_apll
In-Reply-To: <20131219193708.18119.53403@quantum>
References: <1387442019-2445-1-git-send-email-sachin.kamat@linaro.org>
 <20131219193708.18119.53403@quantum>
Message-ID: <3616477.6ZBKa1KffA@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 of December 2013 11:37:08 Mike Turquette wrote:
> Quoting Sachin Kamat (2013-12-19 00:33:39)
> > Add CLK_SET_RATE_PARENT flag to mout_apll clock. This will let us set the
> > clock rate in the cpufreq driver.
> > 
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Ack.

Applied onto next branch.

Best regards,
Tomasz
