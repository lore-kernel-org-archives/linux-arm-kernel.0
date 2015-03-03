From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Mar 2015 10:24:11 +0800
Subject: [PATCH] ARM: imx/iomux-v3: allow pad_list to be const
In-Reply-To: <1424531301-7075-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1424531301-7075-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20150303022409.GC20455@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 21, 2015 at 04:08:21PM +0100, Uwe Kleine-K?nig wrote:
> Also fix all machine files to make use of it and while at it also make
> the pad lists __initconst.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied, thanks.
