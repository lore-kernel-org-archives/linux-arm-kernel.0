From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 14:17:46 +0800
Subject: [PATCH v2] ARM: clk-imx6q: fix video divider for rev T0 1.0
In-Reply-To: <1417647831-30261-1-git-send-email-bisson.gary@gmail.com>
References: <1417647831-30261-1-git-send-email-bisson.gary@gmail.com>
Message-ID: <20141216061745.GB2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 03:03:51PM -0800, Gary Bisson wrote:
> The post dividers do not work on i.MX6Q rev T0 1.0 so they must be fixed
> to 1. As the table index was wrong, a divider a of 4 could still be
> requested which implied the clock not to be set properly. This is the
> root cause of the HDMI not working at high resolution on rev T0 1.0 of
> the SoC.
> 
> Signed-off-by: Gary Bisson <bisson.gary@gmail.com>

Applied, thanks.
