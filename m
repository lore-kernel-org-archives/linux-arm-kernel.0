From: lethal@linux-sh.org (Paul Mundt)
Date: Thu, 7 Apr 2011 01:38:13 +0900
Subject: [PATCH] video: imx-fb: just depend on IMX_HAVE_PLATFORM_IMX_FB
In-Reply-To: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302100144-17176-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110406163805.GA11820@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2011 at 04:29:04PM +0200, Uwe Kleine-K??nig wrote:
> All machines having a imx-fb device now select IMX_HAVE_PLATFORM_IMX_FB,
> so HAVE_FB_IMX can go away and there is no need anymore to explicitly
> depend on ARCH_MX1 or ARCH_MX2.
> 
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> should this go via Sascha's or Paul's tree?
> 
There shouldn't be anything it conflicts with in my tree, so it can go
via either. Most of the imx changes have bypassed the fbdev tree, so I'm
unaware if there are outstanding patches in Sascha's tree at the moment
or not. I can of course take it though.
